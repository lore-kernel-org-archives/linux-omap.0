From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 11:29:11 -0700
Message-ID: <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:4377 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab1D0S3O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 14:29:14 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p3RITCA7017747
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:29:13 -0700
Received: from gwj17 (gwj17.prod.google.com [10.200.10.17])
	by hpaq6.eem.corp.google.com with ESMTP id p3RISwMA007319
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:29:11 -0700
Received: by gwj17 with SMTP id 17so830536gwj.38
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:29:11 -0700 (PDT)
In-Reply-To: <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 11:07 AM, Menon, Nishanth <nm@ti.com> wrote:
> On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrote:
> +l-o
>
>> I'm a little confused about the design for this, and OPP as well. =A0=
OPP
>> matches a struct device * and a frequency to a voltage, which is not=
 a
>> generically useful pairing, as far as I can tell. =A0On Tegra, it is
>> quite possible for a single device to have multiple clocks that each
>> have different voltage requirements, for example the display block c=
an
>> have an interface clock as well as a pixel clock. =A0Simplifying thi=
s to
>> dev + freq =3D voltage seems very OMAP specific, and will be difficu=
lt
>> or impossible to adapt to Tegra.
> We have the same requirements as well(iclk,fclk,pixclk etc..)! We
> group them under voltage domains in OMAP ;). if your issue was a
> ability to have a single freq to a OPP, it is upto SoC to do the
> proper mapping. Concept of an OPP still remains consistent - which is
> for a voltage, there is only so much freq you can drive that specific
> module to.
No, that is still wrong.  You don't drive a module at a frequency, you
drive a clock.  You can't map struct device * 1-1 to a clock.  Look at
omap2_set_init_voltage:
static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name=
,
						struct device *dev) {

	clk =3D  clk_get(NULL, clk_name);
	freq =3D clk->rate;
	opp =3D opp_find_freq_ceil(dev, &freq);
	...
}

Now what happens if I have a dev with two frequencies,

>> Moreover, from a silicon perspective, there is always a simple link
>> from a single frequency to a minimum voltage for a given circuit.
>> There is no need to group them into OPPs, which seem to have a group
>> of clocks and their frequencies that map to a single voltage. =A0Tha=
t is
>> an artifact of the way TI specifies voltages.
>>
>> I don't think DVFS is even the right place for any sort of governor.
>> DVFS is very simple - to increase to a specific clock speed, the
>> voltage must be immediately be raised, with minimum or no delay, to =
a
>> specified value that is specific to that clock. =A0When the frequenc=
y is
>> lowered, the voltage should be decreased. =A0There is a tiny bit of
>> policy to determine when to delay dropping the voltage in case the
>> frequency will immediately be raised again, but nowhere near the
>> complexity of what is shown here.
>>
>> I proposed in a different thread on LKML that DVFS be handled within
>> the generic clock implementation. =A0Platforms would register a
>> regulator and a table of voltages for each struct clock that require=
d
>> DVFS, and the voltages would be changed on normal clk_* requests.
>> This maintains compatibility with existing clk_* calls.
>
> It is upto SoC frameworks to implement the transitions. E.g. lets loo=
k
> at scalability: How'd the mechanism proposed work with temperature
> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
> be an SoC specific hack I'd need to introduce?
>
> All OPP framework does is store that maps, and leaves it to users to
> choose regulators, clock framework variances, SoC temperature sensors
> or what ever mechanisms they choose to allow through a transition.
>
>> There is a place for a GPU, etc., frequency governor, but it is a
>> completely separate issue from DVFS, and should not be mixed in. =A0=
I
>> could have a GPU that is not voltage scalable, but could still benef=
it
>> from lowering the frequency when it is not in use. =A0A devfreq
>> interface sounds perfect for this, as long as it only ends up callin=
g
>> clk_* functions, and those functions handle getting the voltage
>> correct.
>
> Regards,
> Nishanth Menon
> PS:
> https://lists.linux-foundation.org/pipermail/linux-pm/2011-April/0311=
13.html
> for start of thread
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
