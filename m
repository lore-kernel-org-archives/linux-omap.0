From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v7 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Sat, 25 Sep 2010 17:34:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030C8FBC51@dbde02.ent.ti.com>
References: <1285076228-24736-1-git-send-email-charu@ti.com>
	<1285076228-24736-5-git-send-email-charu@ti.com>	<4C992FEF.60106@ti.com>
 <87fwwzarko.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44410 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876Ab0IYMEu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 08:04:50 -0400
In-Reply-To: <87fwwzarko.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> 
> "Cousson, Benoit" <b-cousson@ti.com> writes:
> 
> > On 9/21/2010 3:37 PM, Varadarajan, Charulatha wrote:
> 
> [...]
> 
> >>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
> >>   	/* dmm class */
> >>   	&omap44xx_dmm_hwmod,
> >> @@ -472,6 +602,11 @@ static __initdata struct omap_hwmod
> *omap44xx_hwmods[] = {
> >>
> >>   	/* mpu class */
> >>   	&omap44xx_mpu_hwmod,
> >> +	/* wd_timer class */
> >> +	&omap44xx_wd_timer2_hwmod,
> >> +
> >> +	/* wd_timer3 not yet supported */
> >> +/*	&omap44xx_wd_timer3_hwmod, */
> >
> > Sorry, I forgot to comment that part in your previous revision.
> > What we agreed with Kevin is to enable that hwmod watchdog as well in
> > order to allow the hwmod core to initialize properly this module, even
> > if it not used by any driver yet.
> >
> > Beside that you can add my Acked-by: for the whole series.
> 
> Charu,
> 
> If this is OK with you, can you test with timer3 hwmod enabled, and
> repost an updated version of this patch?
> 
> Then, I will add Benoit's ack and queue this up for 2.6.37.

Already posted the series with this review comment fixed [1].

The latest series (version v8) [1] may also be pulled from [2]

[1] https://patchwork.kernel.org/patch/202152/
[2] git://gitorious.org/omap-pm/linux.git wdt_for_2.6.37

-V Charulatha


