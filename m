From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC][PATCH 1/1] OMAP: voltage: add a hook for normal regulator
 calls
Date: Mon, 5 Dec 2011 16:02:52 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121430391C2@DBDE01.ent.ti.com>
References: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
 <87iplymwwi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1LEQDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 11:03:02 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB5G2wBV016287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 5 Dec 2011 10:03:00 -0600
In-Reply-To: <87iplymwwi.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kattekola, Ravikumar" <rk@ti.com>

Hi Kevin,

On Sat, Dec 03, 2011 at 03:57:57, Hilman, Kevin wrote:
[...]
> >
> > Any comments on this approach? 
> 
> Sorry, I didn't see this patch before, and I don't see it in the
> linux-omap archives either.  Not sure what happened there...
> 
> > This enables us to make use of generic regulators calls from the
> > voltage layer. 
> 
> From this patch, I don't see how the regulator API is being used from
> the voltage layer, so I don't fully understand what you're trying to
> achieve.
> 
> IOW, why should the voltagedomain code be calling the regulator API?
> 
> The voltage domain code was designed with the opposite goal: namely,
> that a regulator driver would be calling the voltage domain layer, not
> vice versa.

Sorry, I should have posted more detail on how we are making use of the 
change proposed here and how it helps in getting cpufreq and DVFS working.

We want to use the existing OMAP implementation of cpufreq (and DVFS) on 
the devices which do not have VC/VP.

The current OMAP cpufreq code under drivers/ invokes clk_set_rate().

We had a look at the future DVFS implementation for OMAP[1] and merged in 
the relevant patches (hope this is close to what's planned).

After this change, cpufreq invokes omap_device_scale(). The DVFS code
makes use of the OPP layer and adds a request for voltage and frequency
change. However, the voltage change request expects the scaling to be done
in scaling functions defined in the voltage layer (vc->scale or vp->scale)

On devices which do not have VC/VP, instead of just hacking the current
implementation to get the voltage scaling done, we thought of adding
a separate path.

Taking the example of AM335x, the regulator used on the EVM is TPS65910 
the driver for which is already present in the mainline kernel.

So, when omap_device_scale() is invoked from cpufreq, we want the voltage
scaling to finally trickle down to a regulator_set_voltage() for the
MPU supply.

The way we have currently done this is-

===

int am33x_mpu_voltdm_scale(struct voltagedomain *voltdm,
				unsigned long target_volt)
{
	int ret = -EINVAL;

	if (!voltdm->regulator)
		return ret;

	ret = regulator_set_voltage(voltdm->regulator, target_volt,
		target_volt + TOLERANCE);

	if (ret)
		pr_debug("Voltage change failed, ret = %d\n", ret);
	else
		pr_debug("Voltage scaled to %d\n",
			regulator_get_voltage(voltdm->regulator));

	return ret;
}

struct omap_vdd_dep_info am33xx_vddmpu_dep_info[] = {
	{.name = NULL, .dep_table = NULL, .nr_dep_entries = 0},
};

static struct omap_vdd_info am33xx_vdd1_info;

int am33x_mpu_voltdm_init(struct voltagedomain *voltdm)
{
	struct regulator *mpu_regulator;
	struct device *mpu_dev;

	mpu_dev = omap_device_get_by_hwmod_name("mpu");
	if (!mpu_dev) {
		pr_warning("%s: unable to get the mpu device\n", __func__);
		return -EINVAL;
	}

	mpu_regulator = regulator_get(mpu_dev, voltdm->name);

	if (IS_ERR(mpu_regulator)) {
		pr_err("%s: Could not get regulator for %s\n",
			__func__, voltdm->name);
		return -ENODEV;
	} else {
		voltdm->regulator = mpu_regulator;
		voltdm->scale = &am33x_mpu_voltdm_scale;
	}

	return 0;
}

static struct voltagedomain am33xx_voltdm_mpu = {
	.name = "mpu",
	.scalable = true,
	.use_regulator = 1,
	.regulator_init = &am33x_mpu_voltdm_init,
	.vdd	= &am33xx_vdd1_info,
};

===

In the init hook we set the voltdm->scale to a function which
invokes regulator_set_voltage(). All the other pieces are already taken
care of by the OPP layer and the DVFS implementation. We just had to add
the OPP data and enable cpufreq for AM335x.

> 
> > Since TI81xx and AM33xx do not have VC/VP we need something like this
> > for implementing DVFS.
> 
> This patch (and changelog) does not make that very clear, since it only
> adds an init-time hook.
> 

Does this approach sound reasonable? If you want to check the implementation,
I could push the cpufreq implementation that we currently have to Arago.

Regards,
Vaibhav

[1] git://gitorious.org/~kristo/omap-pm/omap-pm-work.git:linaro_omap_dvfs
