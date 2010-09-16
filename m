From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v5 5/6] OMAP2PLUS: WDT: use omap_device_build for device
 registration
Date: Thu, 16 Sep 2010 18:35:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD260552@dbde02.ent.ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
 <1284528403-6494-6-git-send-email-charu@ti.com>
 <20100915175248.GC4174@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811Ab0IPNF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 09:05:59 -0400
In-Reply-To: <20100915175248.GC4174@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, September 15, 2010 11:23 PM
> To: Varadarajan, Charulatha
> Cc: wim@iguana.be; linux-watchdog@vger.kernel.org;
> khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Nayak,
> Rajendra; Basak, Partha; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 5/6] OMAP2PLUS: WDT: use omap_device_build for
> device registration
> 
> * Varadarajan, Charulatha <charu@ti.com> [100914 22:18]:
> > Use omap_device_build API instead of platform_device_register for
> > watchdog timer device registration.
> >
> > For OMAP2PLUS chips, the device specific data defined in centralized
> > hwmod database will be used.
> 
> <snip>
> 
> >  static void omap_init_wdt(void)
> >  {
> > -	if (cpu_is_omap16xx())
> > -		wdt_resources[0].start = 0xfffeb000;
> > -	else if (cpu_is_omap2420())
> > -		wdt_resources[0].start = 0x48022000; /* WDT2 */
> > -	else if (cpu_is_omap2430())
> > -		wdt_resources[0].start = 0x49016000; /* WDT2 */
> > -	else if (cpu_is_omap343x())
> > -		wdt_resources[0].start = 0x48314000; /* WDT2 */
> > -	else if (cpu_is_omap44xx())
> > -		wdt_resources[0].start = 0x4a314000;
> > -	else
> > -		return;
> > -
> > -	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
> > -
> > -	(void) platform_device_register(&omap_wdt_device);
> > +	if (cpu_class_is_omap2())
> > +		omap2_init_wdt();
> > +	else if (cpu_is_omap16xx())
> > +		(void) platform_device_register(&omap1_wdt_device);
> > +	return;
> >  }
> >  #else
> >  static inline void omap_init_wdt(void) {}
> 
> Please just split this into separate omap_init_wdt functions
> under mach-omap1 and mach-omap2. Then set them up with
> subsys_initcall and make sure you return early from the
> subsys_initcall if the platform is not the right one.
> 

Okay.

> Tony
