From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification
 for MCBSP
Date: Tue, 7 Dec 2010 18:45:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247C46D6F@dbde02.ent.ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<1286296662-7639-6-git-send-email-kishon@ti.com>	<4CAECB70.4030705@ti.com>
 <4CB2AC44.6000804@ti.com>
	<AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com>
	<AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
	<4CF52044.6040904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFD66A@dbde02.ent.ti.com>
	<4CF62E5A.2080004@ti.com> <87mxoo4f8g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55328 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0LGNQF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:16:05 -0500
In-Reply-To: <87mxoo4f8g.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, December 02, 2010 4:24 PM
> To: Cousson, Benoit
> Cc: Basak, Partha; ABRAHAM, KISHON VIJAY; Paul Walmsley; linux-
> omap@vger.kernel.org; Kamat, Nishant; Varadarajan, Charulatha; Datta,
> Shubhrajyoti; ext-eero.nurkkala@nokia.com; eduardo.valentin@nokia.com;
> Raja, Govindraj
> Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register
> modification for MCBSP
> 
> "Cousson, Benoit" <b-cousson@ti.com> writes:
> 
> [...]
> 
> >
> > The issue is not really for the mcbsp but for the serial that need to
> > handle the 3 different states.
> >
> > 	if (enable) {
> > 		/**
> > 		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
> > 		 * in Smartidle Mode When Configured for DMA Operations.
> > 		 */
> > 		if (uart->dma_enabled)
> > 			idlemode = HWMOD_IDLEMODE_FORCE;
> > 		else
> > 			idlemode = HWMOD_IDLEMODE_SMART;
> > 	} else {
> > 		idlemode = HWMOD_IDLEMODE_NO;
> > 	}
> >
> > You do need to explicitly set the 3 modes, hence the following 3
> APIs:
> > omap_device_force_idle
> > omap_device_no_idle
> > omap_device_smart_idle

I am OK with Benoit's 3 + 1 API approach, 3 individual set functions and
one common function to restore back to the value as dictated by the flag.
What do you say guys?
> >
> > You can potentially add another API to restore the default idle mode:
> >
> > omap_device_default_idle
> >
> > That seems much simpler than 3 pairs of APIs.
> 
> My $0.02... based on the fact that we already have some IPs needing to
> conrol all 3 modes, I think having the 3 functions above is better than
> having 3 pairs of request/release functions.
> 
> Kevin
> 

