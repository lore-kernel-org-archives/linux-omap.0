From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 13:07:02 -0500
Message-ID: <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
 <201104261309.47629.rjw@sisk.pl> <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
 <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41060 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752472Ab1D0SHZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 14:07:25 -0400
Received: by wyi11 with SMTP id 11so1604981wyi.26
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:07:23 -0700 (PDT)
In-Reply-To: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrote:
+l-o

> I'm a little confused about the design for this, and OPP as well. =A0=
OPP
> matches a struct device * and a frequency to a voltage, which is not =
a
> generically useful pairing, as far as I can tell. =A0On Tegra, it is
> quite possible for a single device to have multiple clocks that each
> have different voltage requirements, for example the display block ca=
n
> have an interface clock as well as a pixel clock. =A0Simplifying this=
 to
> dev + freq =3D voltage seems very OMAP specific, and will be difficul=
t
> or impossible to adapt to Tegra.
We have the same requirements as well(iclk,fclk,pixclk etc..)! We
group them under voltage domains in OMAP ;). if your issue was a
ability to have a single freq to a OPP, it is upto SoC to do the
proper mapping. Concept of an OPP still remains consistent - which is
for a voltage, there is only so much freq you can drive that specific
module to.

> Moreover, from a silicon perspective, there is always a simple link
> from a single frequency to a minimum voltage for a given circuit.
> There is no need to group them into OPPs, which seem to have a group
> of clocks and their frequencies that map to a single voltage. =A0That=
 is
> an artifact of the way TI specifies voltages.
>
> I don't think DVFS is even the right place for any sort of governor.
> DVFS is very simple - to increase to a specific clock speed, the
> voltage must be immediately be raised, with minimum or no delay, to a
> specified value that is specific to that clock. =A0When the frequency=
 is
> lowered, the voltage should be decreased. =A0There is a tiny bit of
> policy to determine when to delay dropping the voltage in case the
> frequency will immediately be raised again, but nowhere near the
> complexity of what is shown here.
>
> I proposed in a different thread on LKML that DVFS be handled within
> the generic clock implementation. =A0Platforms would register a
> regulator and a table of voltages for each struct clock that required
> DVFS, and the voltages would be changed on normal clk_* requests.
> This maintains compatibility with existing clk_* calls.

It is upto SoC frameworks to implement the transitions. E.g. lets look
at scalability: How'd the mechanism proposed work with temperature
variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
be an SoC specific hack I'd need to introduce?

All OPP framework does is store that maps, and leaves it to users to
choose regulators, clock framework variances, SoC temperature sensors
or what ever mechanisms they choose to allow through a transition.

> There is a place for a GPU, etc., frequency governor, but it is a
> completely separate issue from DVFS, and should not be mixed in. =A0I
> could have a GPU that is not voltage scalable, but could still benefi=
t
> from lowering the frequency when it is not in use. =A0A devfreq
> interface sounds perfect for this, as long as it only ends up calling
> clk_* functions, and those functions handle getting the voltage
> correct.

Regards,
Nishanth Menon
PS:
https://lists.linux-foundation.org/pipermail/linux-pm/2011-April/031113=
=2Ehtml
for start of thread
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
