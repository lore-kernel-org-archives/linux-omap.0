From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 11:37:07 -0700
Message-ID: <BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:11598 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab1D0ShJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 14:37:09 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p3RIb97B013208
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:37:09 -0700
Received: from gxk2 (gxk2.prod.google.com [10.202.11.2])
	by wpaz21.hot.corp.google.com with ESMTP id p3RIb755012173
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:37:08 -0700
Received: by gxk2 with SMTP id 2so799910gxk.36
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:37:07 -0700 (PDT)
In-Reply-To: <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>

(sorry, missent the earlier one)

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
No, that is still wrong. =A0You don't drive a module at a frequency, yo=
u
drive a clock. =A0You can't map struct device * 1-1 to a clock. =A0Look=
 at
omap2_set_init_voltage:
static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name=
,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev) {
        ...
 =A0 =A0 =A0 =A0clk =3D =A0clk_get(NULL, clk_name);
 =A0 =A0 =A0 =A0freq =3D clk->rate;
 =A0 =A0 =A0 =A0opp =3D opp_find_freq_ceil(dev, &freq);
 =A0 =A0 =A0 =A0...
}

What happens if I have a dev with two frequencies?  I can only pass a
dev into opp.  It makes infinitely more sense to pass in a clock:
opp_find_freq_ceil(clk, &freq).

> It is upto SoC frameworks to implement the transitions. E.g. lets loo=
k
> at scalability: How'd the mechanism proposed work with temperature
> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
> be an SoC specific hack I'd need to introduce?
No, because you're putting it in the wrong place, that is a policy
decision.  Handle it in the clock framework, or handle it in the
device driver.  That's a bad example either way - what happens if you
are already at 1.5GHz when the temperature crosses 70C?  You need an
interrupt that tells you the temperature is too high, and than needs
to affect a policy decision at a much higher level than dvfs.

>
> All OPP framework does is store that maps, and leaves it to users to
> choose regulators, clock framework variances, SoC temperature sensors
> or what ever mechanisms they choose to allow through a transition.
I understand its just a map, but its a map between two things that
don't have a direct mapping in many SoCs.  I think if you changed
every usage of struct dev * in opp to struct clk *, it would make much
more sense.  There is already a mapping from struct dev * to struct
clk *, its called clk_get, and it takes a second parameter to allow
devices to have multiple clocks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
