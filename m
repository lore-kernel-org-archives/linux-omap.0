From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Mon, 14 Dec 2009 14:31:56 +0530
Message-ID: <4B25FF04.4040306@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>	<87skbhjwjo.fsf@deeprootsystems.com> <87my1pggok.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34299 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZLNJCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 04:02:03 -0500
In-Reply-To: <87my1pggok.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> [...]
> 
>> PMC code is ARM generic and already largely exists in other places
>> (oprofile for one.)  So the use of the PMC will need to be generalized
>> as well as be shown not to interfere with other users (as raised
>> already by Jean Pihet.)
> 
> Someone is already trying to generalize a PMC interface.  You might want
> to follow this thread:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005898.html
> 
I tried to find the code in LO but I think it is not yet present. So with that
in mind may I propose that the pmc functions we introduce in plat-omap will be
present as __init code (so that we ensure no one uses it after the system
finishes booting up) as long as the pmc infrastructure is not available for
non-Oprofile uses? As I mentioned in an earlier thread, the pmc is used and
stopped very early during the kernel boot and AFAICT there should not be any
problem (probably we need to check its behavior on EMU/HS devices).

Thanks,
-Romit
