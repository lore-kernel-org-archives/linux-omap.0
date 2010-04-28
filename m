From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: RE: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 12:02:04 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC2877B93@dlee04.ent.ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
	<t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>
	<4BD8430B.80909@ti.com> <87bpd3h774.fsf@deeprootsystems.com>
 <4BD863FE.80804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab0D1RCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 13:02:10 -0400
In-Reply-To: <4BD863FE.80804@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Wednesday, April 28, 2010 11:36 AM
> To: Kevin Hilman
> Cc: Ramirez Luna, Omar; Felipe Contreras; linux-omap; Ameya Palande;
> Hiroshi Doyu; Felipe Contreras; Omar Ramirez Luna
> Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
> 
> Kevin Hilman had written, on 04/28/2010 11:29 AM, the following:
> > Omar Ramirez Luna <omar.ramirez@ti.com> writes:
> >
> >> On 4/28/2010 2:46 AM, Felipe Contreras wrote:
> >>> On Wed, Apr 28, 2010 at 4:29 AM, Omar Ramirez
> Luna<omar.ramirez@ti.com>  wrote:
> >>>> This patch switches to use DM timer framework instead of
> >>>> a custom one for GPT timers, currently dsp can make use of
> >>>> gpt 5, 6, 7 or 8.
> >>> I heard someone that was using gpt 8 for something else. Is it
> >>> possible to configure dsp-bridge to not use it?
> >>>
> >> There are two scenarios:
> >>
> >> 1. The request comes from the DSP side (afaik for video use case), the
> >> change should be in the DSP side binaries to request some other gpt
> >> instead. I don't know how possible is to get this changed.
> >>
> >> 2. bridge driver also requests gpt8 whenever a mmu fault is triggered,
> >> this to set a timer to interrupt the dsp after the mmu fault dump has
> >> been finished, I think this can be easily replaced in bridge to use
> >> some other gpt, but "1" is still there. (besides a new patch is needed
> >> to remove direct access to dm timer inside ue_deh and make it to go
> >> through dsp-clock)
> >
> > Why does Bridge care at all which specific timers it requests?  They
> > are all the same, with the exception of GPT1 which is in the WKUP
> > powerdomain and already used as the kernel clocksource.
> >
> > Bridge should just use the generic _request() instead of
> > _request_specific()
> >
> trouble I believe is that DSP BIOS uses a specific timer.

DSP/BIOS uses GPT5 on bridge boot up, after that the GPT5 is released.
The GPT6 is used in DSP Bridge for DSP CPU Load Monitoring.

Regards,
Armando.

