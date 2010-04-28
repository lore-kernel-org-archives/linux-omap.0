From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 09:29:03 -0700
Message-ID: <87bpd3h774.fsf@deeprootsystems.com>
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
	<4BD8430B.80909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58232 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab0D1Q3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 12:29:08 -0400
Received: by pwj9 with SMTP id 9so10506277pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 09:29:05 -0700 (PDT)
In-Reply-To: <4BD8430B.80909@ti.com> (Omar Ramirez Luna's message of "Wed\, 28 Apr 2010 09\:15\:39 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> On 4/28/2010 2:46 AM, Felipe Contreras wrote:
>> On Wed, Apr 28, 2010 at 4:29 AM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>>> This patch switches to use DM timer framework instead of
>>> a custom one for GPT timers, currently dsp can make use of
>>> gpt 5, 6, 7 or 8.
>>
>> I heard someone that was using gpt 8 for something else. Is it
>> possible to configure dsp-bridge to not use it?
>>
>
> There are two scenarios:
>
> 1. The request comes from the DSP side (afaik for video use case), the
> change should be in the DSP side binaries to request some other gpt
> instead. I don't know how possible is to get this changed.
>
> 2. bridge driver also requests gpt8 whenever a mmu fault is triggered,
> this to set a timer to interrupt the dsp after the mmu fault dump has
> been finished, I think this can be easily replaced in bridge to use
> some other gpt, but "1" is still there. (besides a new patch is needed
> to remove direct access to dm timer inside ue_deh and make it to go
> through dsp-clock)

Why does Bridge care at all which specific timers it requests?  They
are all the same, with the exception of GPT1 which is in the WKUP
powerdomain and already used as the kernel clocksource.

Bridge should just use the generic _request() instead of
_request_specific()

Kevin
