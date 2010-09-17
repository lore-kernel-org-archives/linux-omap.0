From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Fri, 17 Sep 2010 15:26:56 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C42@dbde02.ent.ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
 <1284528403-6494-5-git-send-email-charu@ti.com> <4C91382F.1060505@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307BEA@dbde02.ent.ti.com>
 <4C933B1F.2040100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55201 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0IQJ5E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 05:57:04 -0400
In-Reply-To: <4C933B1F.2040100@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Friday, September 17, 2010 3:26 PM
> To: Varadarajan, Charulatha
> Cc: tony@atomide.com; wim@iguana.be; linux-watchdog@vger.kernel.org;
> khilman@deeprootsystems.com; paul@pwsan.com; Nayak, Rajendra; Basak,
> Partha; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
> 
> Hi Charu,
> 
> On 9/17/2010 11:23 AM, Varadarajan, Charulatha wrote:
> >
> >
> >> -----Original Message-----
> >> From: Cousson, Benoit
> >> Sent: Thursday, September 16, 2010 2:49 AM
> >> To: Varadarajan, Charulatha
> >> Cc: tony@atomide.com; wim@iguana.be; linux-watchdog@vger.kernel.org;
> >> khilman@deeprootsystems.com; paul@pwsan.com; Nayak, Rajendra; Basak,
> >> Partha; linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
> >>
> >> Hi Charu,
> >>
> >> On 9/15/2010 7:26 AM, Varadarajan, Charulatha wrote:
> >>> From: Benoit Cousson<b-cousson@ti.com>
> >>>
> >>> Add watchdog timer hwmod data for OMAP4 chip
> >>>
> >>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>> Signed-off-by: Charulatha V<charu@ti.com>
> >>> ---
> > <<snip>>
> >
> >>> @@ -472,6 +538,8 @@ static __initdata struct omap_hwmod
> >> *omap44xx_hwmods[] = {
> >>>
> >>>    	/* mpu class */
> >>>    	&omap44xx_mpu_hwmod,
> >>> +	/* wd_timer class */
> >>> +	&omap44xx_wd_timer2_hwmod,
> >>>    	NULL,
> >>>    };
> >>
> >> What about the wd_timer3? It is in the audio backend, and I'm not sure
> >> who will use it, but it does exist.
> >
> > As you mentioned, wd_timer3 in OMAP4 is an IVA3 watchdog timer.
> >
> > Also the current watchdog driver (omap_wdt.c) does not support more than
> one watchdog timer. To add this support we need to first redesign the
> driver code and then add wd_timer3 to the database.
> >
> > This patch series is intended to make watchdog driver to use omap_hwmod
> APIs and PM runtime APIs. Driver modification to support more than one
> watchdog timers can be taken up as a separate activity later.
> 
> No necessarily, even if you do not manage this watchdog, we do need to
> expose its hwmod in order to allow dspbridge/syslink to potentially
> enable or disable it.
> 
> Maybe, it should be up to syslink people to do that then.
> In that case, please add comment in the DB to explain that we do have
> other instances but they are not managed yet.

Okay. Sure will do that.

> 
> Thanks,
> Benoit
