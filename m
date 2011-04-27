From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 11:54:04 -0700
Message-ID: <BANLkTi=8k9xKB3K3NoxCAZ16eSS82qeqBA@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:18330 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab1D0SyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 14:54:09 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p3RIs5rg025312
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:54:05 -0700
Received: from yie30 (yie30.prod.google.com [10.243.66.30])
	by hpaq3.eem.corp.google.com with ESMTP id p3RIqal8029524
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:54:04 -0700
Received: by yie30 with SMTP id 30so904222yie.23
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 11:54:04 -0700 (PDT)
In-Reply-To: <BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 11:48 AM, Menon, Nishanth <nm@ti.com> wrote:
> On Wed, Apr 27, 2011 at 13:29, Colin Cross <ccross@google.com> wrote:
>> On Wed, Apr 27, 2011 at 11:07 AM, Menon, Nishanth <nm@ti.com> wrote:
>>> On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrot=
e:
>>> +l-o
>>>
>>>> I'm a little confused about the design for this, and OPP as well. =
=A0OPP
>>>> matches a struct device * and a frequency to a voltage, which is n=
ot a
>>>> generically useful pairing, as far as I can tell. =A0On Tegra, it =
is
>>>> quite possible for a single device to have multiple clocks that ea=
ch
>>>> have different voltage requirements, for example the display block=
 can
>>>> have an interface clock as well as a pixel clock. =A0Simplifying t=
his to
>>>> dev + freq =3D voltage seems very OMAP specific, and will be diffi=
cult
>>>> or impossible to adapt to Tegra.
>>> We have the same requirements as well(iclk,fclk,pixclk etc..)! We
>>> group them under voltage domains in OMAP ;). if your issue was a
>>> ability to have a single freq to a OPP, it is upto SoC to do the
>>> proper mapping. Concept of an OPP still remains consistent - which =
is
>>> for a voltage, there is only so much freq you can drive that specif=
ic
>>> module to.
>> No, that is still wrong. =A0You don't drive a module at a frequency,=
 you
>> drive a clock. =A0You can't map struct device * 1-1 to a clock. =A0L=
ook at
> Agreed, module runs on clocks - Lets say n clocks provide a module
> it's functionality.
>
>> omap2_set_init_voltage:
>> static int __init omap2_set_init_voltage(char *vdd_name, char *clk_n=
ame,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev) {
>>
>> =A0 =A0 =A0 =A0clk =3D =A0clk_get(NULL, clk_name);
>> =A0 =A0 =A0 =A0freq =3D clk->rate;
>> =A0 =A0 =A0 =A0opp =3D opp_find_freq_ceil(dev, &freq);
>> =A0 =A0 =A0 =A0...
>> }
>>
>> Now what happens if I have a dev with two frequencies,
> we do have it - it depends on what the OPP table represents. we do
> have modules which have both interface and functional clocks on OMAP
> as well. for a module(represented by struct device *) which has n
> clocks, choose the scheme of representation of clock that depends on
> voltage for the module.
> in the example you provided "the display block can have an interface
> clock as well as a pixel clock" - I suppose you mean:
> {.pclk =3D x, .iclk =3D y, .v =3D z}
> The question I'd ask is this : for a voltage z, is the dependency on
> pclk or iclk? I can expect a dependency of pclk to iclk requirement
> (considering pixel clock drives an external display for example). the
> table reduces to just
> {.iclk =3D y, .v =3D z} and a different table that has divisor for .i=
clk
> to pclk which is SoC based.

No, there can be voltage requirements on both, and the higher voltage
requirement of the two must be used.

> OPP table is just a storage and retrieval mechanism, it is upto SoC
> frameworks to choose the most adequate of solutions - e.g. OMAP has
> omap_device, hwmod and a clock framework for more intricate control t=
o
> work in conjunction with cpuidle frameworks as well.
>
> There is cross domain dependency which OMAP (yet to be pushed to
> mainline) has - example: when OMAP4's MPUs are at a certain OPP, L3
> (OMAP's SoC bus) needs to be at least a certain OPP - these are
> framework which may be very custom to OMAP itself.
>
> ---
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
