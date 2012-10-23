From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Tue, 23 Oct 2012 07:28:12 -0700
Message-ID: <87txtlb6v7.fsf@deeprootsystems.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:52643 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2JWO1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 10:27:45 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1950742dak.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 07:27:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 23 Oct 2012 07:47:44 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Tero,
>
> On Mon, 22 Oct 2012, Tero Kristo wrote:
>
>> When waking up from off-mode, some IP blocks are reset automatically by
>> hardware. For this reason, software must wait until the reset has
>> completed before attempting to access the IP block.
>> 
>> This patch fixes for example the bug introduced by commit
>> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
>> to SYSCONFIG register"), in which the MMC IP block is reset during
>> off-mode entry, but the code expects the module to be already available
>> during the execution of context restore.
>> 
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Venkatraman S <svenkatr@ti.com>
>
> What do you think about these modifications?  The code is quite similar to 
> what was in the _ocp_softreset() function, so just moved it into a 
> function.  Also moved the callsite from the end of _enable_sysc() to the 
> beginning, which makes more sense to me, but would like to get your 
> opinion.

FYI, after some more testing with this patch, I noticed that this patch
(and the original from Tero) cause some sluggishness on UART1 console my
37xx/EVM platform as soon as off-mode is enabled (even without the UART
autosuspend timeouts enabled.)  I don't see this on any other OMAP3
platform but all the others I have have UART3 console (in PER), the EVM
is the only one with UART1 console (in CORE.)

I haven't debugged this any furhter, but thought it should be reported
before this gets merged.

Kevin
