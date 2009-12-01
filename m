From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3evm: touchscreen delays on pm branch
Date: Tue, 1 Dec 2009 21:35:56 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE879FAD@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
	 <4B0F9045.6030404@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>
	 <1259312859.19138.4.camel@boson>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>
	 <040b01ca6f4d$38ac95c0$LocalHost@wipultra793>
 <8bf247760912010206v2dc79ec0gc1f0ab369fdabd85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951AbZLAQFz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 11:05:55 -0500
In-Reply-To: <8bf247760912010206v2dc79ec0gc1f0ab369fdabd85@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriram V <vshrirama@gmail.com>, "V, Hemanth" <hemanthv@ti.com>
Cc: "Dasgupta, Romit" <romit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Sriram V [mailto:vshrirama@gmail.com]=20
> Sent: Tuesday, December 01, 2009 3:36 PM
> To: V, Hemanth
> Cc: Premi, Sanjeev; Dasgupta, Romit; linux-omap@vger.kernel.org
> Subject: Re: omap3evm: touchscreen delays on pm branch
>=20
> Hi,
>   Have you enabled CPUFREQ? We faced a similar issue and was due to
> ondemand governor.
>  Selecting performance governors solved the issue.

Nope. No cpufreq. I did notice that CPIO175 was not being set
properly; have made local changes. It is a definite improvement;
but there are still very noticeable delays.

I will post the GPIO related patches in a few days; currently
drowned in few debug issues :(

Best regards,
Sanjeev

>=20
>=20
> Regards,
> sriram
>=20
>=20
>=20
>=20
>=20
> On Fri, Nov 27, 2009 at 4:04 PM, Hemanth V <hemanthv@ti.com> wrote:
> > ----- Original Message ----- From: "Premi, Sanjeev" <premi@ti.com>
> > To: "Dasgupta, Romit" <romit@ti.com>
> > Cc: <linux-omap@vger.kernel.org>
> > Sent: Friday, November 27, 2009 3:20 PM
> > Subject: RE: omap3evm: touchscreen delays on pm branch
> >
> >
> >>> -----Original Message-----
> >>> From: Dasgupta, Romit Sent: Friday, November 27, 2009 2:38 PM
> >>> To: Premi, Sanjeev
> >>> Cc: linux-omap@vger.kernel.org
> >>> Subject: RE: omap3evm: touchscreen delays on pm branch
> >>>
> >>> On Fri, 2009-11-27 at 14:11 +0530, Premi, Sanjeev wrote:
> >>> > > -----Original Message-----
> >>> > > From: Dasgupta, Romit > > Sent: Friday, November 27,=20
> 2009 2:10 PM
> >>> > > To: Premi, Sanjeev
> >>> > > Cc: linux-omap@vger.kernel.org
> >>> > > Subject: Re: omap3evm: touchscreen delays on pm branch
> >>> > > > > Premi, Sanjeev wrote:
> >>> > > > Hi,
> >>> > > > > > > I am finding the response of touchscreen on=20
> the omap3evm very
> >>> > > > > > > slow.
> >>> > > > > > > Here is my test:
> >>> > > > On console, I run : watch -n2 "cat /proc/interrupts"
> >>> > > > Then, I tap the touchscreen approximately once per=20
> second. However,
> >>> > > > (usually) no interrupts are registered. As I=20
> increase the frequency
> >>> > > > of 'taps' more and more interrupts are registered.=20
> But still not
> >>> > > > matching exact taps.
> >>> > > > > > > However, when I keep the cpu busy with "cat=20
> /dev/zero >
> >>> > > > > > > /dev/null &"
> >>> > > > each tap is recognized.
> >>> > > > > > Do you see this even if we don't enable OFF?
> >>> > > > Yes. Sleep_while_idle=3D0; enable_off_mode=3D0
> >>> > ~sanjeev
> >>>
> >>> Hopefully you have the same TSC driver. Nevertheless, can=20
> you please try
> >>> this (just to see if clock domain idling is causing any=20
> problem or not):
> >>
> >> It is the same driver at SDP3430. I had earlier tried removing
> >> cpuidle altogether and did not see this issue. I too believe that
> >> issue is caused by clocks being going to (auto)idle.
> >>
> >> But then, Hemanth should be seeing the same behavior.
> >
> > Zoom2/Zoom3 use a different touchscreen driver compared to SDP.
> > Its uses Synaptic Touchscreen over I2C.
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
