From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/13] OMAP: hwmod data: add class for DSP hwmods
Date: Thu, 24 Jun 2010 14:34:41 -0700
Message-ID: <87mxukyv0u.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-13-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006241243130.1550@utopia.booyaka.com>
	<87fx0c6udw.fsf@deeprootsystems.com>
	<87y6e415rg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46309 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0FXVeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 17:34:44 -0400
Received: by pvg2 with SMTP id 2so550358pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 14:34:43 -0700 (PDT)
In-Reply-To: <87y6e415rg.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 24 Jun 2010 14:26:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> Hi Kevin,
>>>
>>> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>>>
>>>> Add a new hwmod class for DSP devices.  To be used when hwmods
>>>> are created for DSP on OMAP3 (a.k.a. IVA2.)
>>>
>>> I guess this patch is not needed any more?  But if it is, it might be best 
>>> to name the class "iva2" or something like that, since the IVA2 subsystem 
>>> contains more than just the DSP; it also contains the dedicated hardware 
>>> video accelerator blocks, which are separate from the DSP.
>>
>> Right, I'll be dropping this patch too as I'm just switching to use
>> omap_hwmod_lookup() instead of the class iterators.
>
> Turns out I need a class even when doing the omap_hwmod_lookup()
> as omap_hwmod_register() fails if there is no class or class name.
>
> I'll keep this pach but s/dsp/iva2/
>

On second thought, I'll use "iva" to match how the naming was done for
OMAP4.

Kevin
