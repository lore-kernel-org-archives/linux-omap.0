From: NeilBrown <neilb@suse.de>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Sat, 28 Jan 2012 09:35:30 +1100
Message-ID: <20120128093530.0a0a370a@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
	<20120118082410.48262777@notabene.brown>
	<alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
	<20120124213705.49f042bf@notabene.brown>
	<alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/NO23y7sXomcKJVn1zwxCUy/"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36327 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab2A0Wfo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 17:35:44 -0500
In-Reply-To: <alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/NO23y7sXomcKJVn1zwxCUy/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jan 2012 07:19:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> On Tue, 24 Jan 2012, NeilBrown wrote:
>=20
> > On Sat, 21 Jan 2012 17:07:18 -0700 (MST) Paul Walmsley <paul@pwsan.com>=
 wrote:
> >=20
> > > On Wed, 18 Jan 2012, NeilBrown wrote:
> > >=20
> > > > Oh - another thing.
> > > > Sometimes during early boot I get:
> > > >=20
> > > > [    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbt=
ll_fck.
> > > > [    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)
> > >=20
> > > This latter bug just got fixed, it's updated in the new HDQ series th=
at I=20
> > > sent out:
> > >=20
> > > http://marc.info/?l=3Dlinux-omap&m=3D132719073710874&w=3D2
> > >=20
> > > BTW, if you could give that a spin for us at some point, it would be=
=20
> > > greatly appreciated; I don't think I have a board with a 1-wire devic=
e on=20
> > > it (at least, not that I know of).
> >=20
> > Yes, the patch series seems to work OK - at least it doesn't break anyt=
hing:
> > I can still access my battery charge meter.
>=20
> Thanks.  Should I add a Tested-by: from you on those patches?

Well... I only tested them after backporting to 3.2, and Linus is a big
proponent of the idea that once you rebase patches you invalidate any
testing....
However I don't think there difference between 3.2 and 3.3-rc1 is big enough
in the area, so yes:

   Tested-by: NeilBrown <neilb@suse.de>

Thanks.


>=20
> > It doesn't fix the problem I am having where HDQ gets confused when CPU=
IDLE
> > kicks in, but I think I might have a handle on that now.
> >=20
> > Unlike other modules, HDQ doesn't have SIDLEMODE.
> > According to 18.4.5 (AM/DM37x Multimedia Device Silicon Revision) it ac=
ts as
> > though SIDLEMODE were set to SIDLE_FORCE so if the clock-domain trys to
> > switch off, HDQ lets it.
>=20
> Hmm.  Do you know if the problem occurs in the middle of the HDQ=20
> transaction, or when HDQ is completely idle?  I'd suspect the former.

I cannot tell.  Each transaction involves receiving two interrupts - one to
say the write completed and one to say the read completed.
I don't recall seeing any transaction which got the write-completion
interrupt but not the read-completion, but I haven't watched closely enough
to be sure.

>=20
> Here's a theory: perhaps the MPU powerdomain is hitting a low-power state=
=20
> while waiting for an HDQ interrupt.  When the MPU powerdomain is in a low=
=20
> power state, so is the MPU interrupt controller, so the only way that the=
=20
> MPU can wake up is if the HDQ can issue a wakeup event to the PRCM.  And =
I=20
> don't see any evidence that the HDQ is capable of doing this, based on th=
e=20
> HDQ sections of the TRM.  What a huge energy waste, if true.

In the config I am testing MPU only goes to RET, never OFF. Same for CORE.

>=20
> Maybe try something like the following patch -- compile-tested only here.
>=20
> If this works, you might want to try dropping this patch and using the pa=
d=20
> mux to set a wakeup event on the 1-wire pad when the signal goes low. =20
> That might be a more power-efficient approach.  You may still have to use=
=20
> some PM QoS request there to ensure that the HDQ can wake up fast enough=
=20
> to see the pulse, but the constraint shouldn't need to be as ludicrously=
=20
> low as it is in the following patch.

Doesn't work - crashes :-(

pm_qos_power_init is defined as a late_initcall, so you cannot call
pm_qos_update_request until after all the initcalls have run.
But with your patch, the probe of the bq27000 triggers a read of the regist=
ers
which tries to update_request - and it goes 'bang'.

I really think the problem is the CORE pwrdm gating a clock because no modu=
le
says it needs it - i.e. nothing to do with MPU at all.

We want to keep CORE active when an HDQ transaction is happening, but MPU is
welcome to go to sleep.  I don't think you can express that with 'qos'.  I
think it needs some omap-specific machinery.

I can 'fix' the problem simply by making sure

		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);

runs in omap3_enter_idle whenever HDQ is active.

One of the reasons that I think it is a clock problem rather than just
missing a wakeup event is that once the problem starts happening I cannot
recovery without rebooting.
i.e. even if I tell the UARTs to keep the clocks on permanently and keep the
CPUIDLE state at 0, the HDQ doesn't start working again.  It has clearly
become confused.
The HDQ doco makes a point of saying that you shouldn't issue any commands
(except 'enable clock') when the clock is disabled.  I think we end up doing
that and it gets confused and cannot recover.

I note that there is an ad-hoc dependency between the camera and various
power states as well.  Maybe we need a little bit of infrastructure so that
camera can say "Keep CORE and MPU on" (or whatever it needs) and HDQ can say
"Keep CORE on".  ???

Thanks,
NeilBrown


>=20
>=20
> - Paul
>=20
> commit 92fa561191b60ddf1296e02a6206160e8a5718f0
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Thu Jan 26 07:04:40 2012 -0700
>=20
>     Attempt to work around lack of HDQ wakeup support
>=20
> diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
> index 63e3eda..990e38b 100644
> --- a/drivers/w1/masters/omap_hdq.c
> +++ b/drivers/w1/masters/omap_hdq.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/sched.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
> =20
>  #include <asm/irq.h>
>  #include <mach/hardware.h>
> @@ -61,6 +62,8 @@ struct hdq_data {
>  	/* lock status update */
>  	struct  mutex		hdq_mutex;
>  	int			hdq_usecount;
> +	struct pm_qos_request	pm_qos_request;
> +
>  	u8			hdq_irqstatus;
>  	/* device lock */
>  	spinlock_t		hdq_spinlock;
> @@ -409,6 +412,18 @@ static int omap_hdq_get(struct hdq_data *hdq_data)
>  		goto rtn;
>  	}
> =20
> +	/*
> +	 * XXX Horrible hack to keep the MPU powerdomain out of a
> +	 * low-power state during HDQ transfers, since the HDQ doesn't
> +	 * appear to be able to wake the system.  This constraint is
> +	 * way too short - it will probably keep the MPU out of WFI
> +	 * which is a total waste - but we don't have a
> +	 * platform-independent way to control powerdomain states at
> +	 * the moment and there is no obvious replacement for platform_data
> +	 * fn ptrs AFAIK
> +	 */
> +	pm_qos_update_request(&hdq_data->pm_qos_request, 1);
> +
>  	if (OMAP_HDQ_MAX_USER =3D=3D hdq_data->hdq_usecount) {
>  		dev_dbg(hdq_data->dev, "attempt to exceed the max use count");
>  		ret =3D -EINVAL;
> @@ -464,6 +479,10 @@ static int omap_hdq_put(struct hdq_data *hdq_data)
>  		if (0 =3D=3D hdq_data->hdq_usecount)
>  			pm_runtime_put_sync(hdq_data->dev);
>  	}
> +
> +	pm_qos_update_request(&hdq_data->pm_qos_request,
> +			      PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE);
> +
>  	mutex_unlock(&hdq_data->hdq_mutex);
> =20
>  	return ret;
> @@ -578,6 +597,10 @@ static int __devinit omap_hdq_probe(struct platform_=
device *pdev)
>  	hdq_data->hdq_usecount =3D 0;
>  	mutex_init(&hdq_data->hdq_mutex);
> =20
> +	pm_qos_add_request(&hdq_data->pm_qos_request,
> +			   PM_QOS_CPU_DMA_LATENCY,
> +			   PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE);
> +
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
> =20


--Sig_/NO23y7sXomcKJVn1zwxCUy/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyMmsjnsnt1WYoG5AQIUQQ/9FIPlXedeZXDzO/bN5RCB1w2r2hojIZgz
oN+sCQLm4ZVHz7mjOWtIGi4HH3ArCopDAkJ9fsM+FRyEG2L2KzAjX1WtxCAduloq
wykKHVB7rKc8Avj5O+TneSfBHpvUb/mQbalS5ewBxrL94S/Wr2Wb3ruFa9xeayd+
KMx2BDziShdNNUge3Rs+oRUO/IxPWpcRTP92kKRNGcmkR2W5sijE08vXfA0E/Aud
o0VmqbmXxVaAun/eQv+pEB2pgfHPuzTBiz8G7vlJ0Xq5WEykhi8jAFRkYblF06rF
92C4pjyBZ5h9qchItiOUt4M0Y0bf/hwiNz3I5RNR3FcJju8C5cAMwzkyfST3Hvm6
YTneEBH7xCFxuhNbWEBIhjMrSovMML+VHBoDCmhSF/JxaX5rf8s1MFm8yE/n3My0
aw8XLLhLo943E5QNgjlG8dgOC7cregb5qp0dQqYsRm5/qufktxo84K5KRWpG1SmC
qO2kubVRQjrhlLT+CGsXvevWfVLrftMj228nvYtT0KXyLWbf5D1R/Y0XaX3wT+dt
lSQ9LCc4ZmOPKeWVnC331nE6puRRpJ60C5btHTAjnB0yNbmVr2W/HNhnH7Iu7gq+
LV2AY2jaI8XqYIcHFT5ZJG6owmOqttxHBhWy9mHP0CUbJRbT6/v5cAaaR8OrWmGR
lRhNY1yeZt0=
=r/yW
-----END PGP SIGNATURE-----

--Sig_/NO23y7sXomcKJVn1zwxCUy/--
