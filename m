From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization delay
Date: Mon, 14 Dec 2009 08:10:45 -0800
Message-ID: <873a3dfse2.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>
	<87my1pggok.fsf@deeprootsystems.com> <4B25FF04.4040306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:45880 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757676AbZLNQKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:10:49 -0500
Received: by pzk1 with SMTP id 1so2366709pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 08:10:49 -0800 (PST)
In-Reply-To: <4B25FF04.4040306@ti.com> (Romit Dasgupta's message of "Mon\, 14 Dec 2009 14\:31\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit Dasgupta <romit@ti.com> writes:

> Kevin Hilman wrote:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>> 
>> [...]
>> 
>>> PMC code is ARM generic and already largely exists in other places
>>> (oprofile for one.)  So the use of the PMC will need to be generalized
>>> as well as be shown not to interfere with other users (as raised
>>> already by Jean Pihet.)
>> 
>> Someone is already trying to generalize a PMC interface.  You might want
>> to follow this thread:
>> 
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005898.html
>> 
>
> I tried to find the code in LO but I think it is not yet present. 

Right, it is still being discussed.

> So with that in mind may I propose that the pmc functions we
> introduce in plat-omap will be present as __init code (so that we
> ensure no one uses it after the system finishes booting up) as long
> as the pmc infrastructure is not available for non-Oprofile uses? 

Personally, I don't like this idea.

IMHO, the PMC is not OMAP specific and does not belong in plat-omap
even as init code.  Either generalize and use existing PMC
infrastructure, or use a different timer.

You didn't answer my other question about whether or not a GPtimer
could be used for this.  You could quickly request/program/free a
GPtimer for this too using the omap_dm_timer* API.

> As I mentioned in an earlier thread, the pmc is used and stopped
> very early during the kernel boot and AFAICT there should not be any
> problem (probably we need to check its behavior on EMU/HS devices).

This isn't very convicing.  

Also, it's not just oprofile we have to be worried about.  The
perf/trace infrastructure arm is also using the PMC.  It will not be
uncommon to use perf on early boot/init and the use of the PMC in this
patch will clearly interfere with that.

In summary, the PMC is a shared resource and should be treated as such
using common code and common APIs.

Kevin

