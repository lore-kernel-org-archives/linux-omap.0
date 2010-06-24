From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/13] OMAP: hwmod data: add class for DSP hwmods
Date: Thu, 24 Jun 2010 13:35:55 -0700
Message-ID: <87fx0c6udw.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-13-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006241243130.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64843 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab0FXUf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 16:35:58 -0400
Received: by pwj8 with SMTP id 8so2022574pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 13:35:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006241243130.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 24 Jun 2010 12:44:49 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> Add a new hwmod class for DSP devices.  To be used when hwmods
>> are created for DSP on OMAP3 (a.k.a. IVA2.)
>
> I guess this patch is not needed any more?  But if it is, it might be best 
> to name the class "iva2" or something like that, since the IVA2 subsystem 
> contains more than just the DSP; it also contains the dedicated hardware 
> video accelerator blocks, which are separate from the DSP.

Right, I'll be dropping this patch too as I'm just switching to use
omap_hwmod_lookup() instead of the class iterators.

Kevin
