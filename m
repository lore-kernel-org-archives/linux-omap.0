From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Tue, 23 Feb 2010 15:29:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A2036B@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
 <87bpfqkhan.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab0BWKAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 05:00:05 -0500
In-Reply-To: <87bpfqkhan.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Jouni,

> -----Original Message-----
> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
> Sent: Monday, February 15, 2010 2:27 PM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath; Paul Walmsley; =
Kevin
> Hilman
> Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall la=
tency
> during DVFS
>=20
> "ext Reddy, Teerth" <teerth@ti.com> writes:
>=20
> > From: Teerth Reddy <teerth@ti.com>
> >
> > Dynamic Calculation of SDRC stall latency during DVFS
> >
> > The patch has the changes to calculate the dpll3 clock stabilizatio=
n
> delay dynamically. The SRAM delay is calibrated during bootup using t=
he
> gptimers and used while calculating the stabilization delay. By using=
 the
> dynamic method the dependency on the type of cache being used is remo=
ved.
> Hence there is no need of loop based calculation.
> >
> > The wait time for L3 clock stabilization is calculated using the fo=
rmula
> : 4*REFCLK + 8*CLKOUTX2, which uses the M, N and M2 read from the
> registers.Since this value gives slightly less value, 2us is added as
> buffer for safety.
> > This works fine for omap3.
>=20
> I think you could make a difference on 3630 in this patch. 3630 has
> different formula to calculate needed delay after setting m2 divider.

We have considered the worst case scenario and used this formula which =
holds good for 3630 as well. We have used register dump and  observabil=
ity  signal analysis to comeup with this formula.


Regards
Teerth
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
