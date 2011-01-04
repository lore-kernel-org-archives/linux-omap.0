From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Tue, 04 Jan 2011 14:37:23 -0600
Message-ID: <4D238503.6070103@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com> <20110103223656.GA8414@n2100.arm.linux.org.uk> <4D22503F.9060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45191 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab1ADUh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 15:37:26 -0500
Received: by mail-yx0-f170.google.com with SMTP id 11so5444011yxi.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 12:37:26 -0800 (PST)
In-Reply-To: <4D22503F.9060100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

Nishanth Menon had written, on 01/03/2011 04:39 PM, the following:
> Russell King - ARM Linux had written, on 01/03/2011 04:36 PM, the 
> following:
>> On Mon, Jan 03, 2011 at 12:58:28PM -0600, Nishanth Menon wrote:
>>> Source:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>>> branch: omap-for-linus
>>>
>>> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
>>> resulted in the following sparse warnings:
>>> http://pastebin.mozilla.org/907954
>>
>> FYI, you may like to try:
>>
>> make C=2 arch/arm/mach-omap2/
>>
>> instead of the two-step process:
>> | Do a kernel make with "make C=1" to run sparse on all the C files 
>> that get
>> | recompiled, or use "make C=2" to run sparse on the files whether 
>> they need to
>> | be recompiled or not.  The latter is a fast way to check the whole 
>> tree if you
>> | have already built it.
> Gee thanks. /me should update my old bash aliases :D
hmm.. minor nit (with codesourcery 2010.09-50 - 4.5.1):
rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/ 2>Kerr;make C=2 
arch/arm/mach-omap2/ 2>Kerr1;diff Kerr Kerr1
[..]
1,4d0
< arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_by_name':
< arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used 
uninitialized in this function
< arch/arm/mach-omap2/clkt_clksel.c: In function 'omap2_clksel_set_parent':
< arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be 
used uninitialized in this function

Kinda interesting to note that C=2 does'nt list all potential gcc 
warnings :( if one wanted a collated list of all warnings, rm .../*.o 
helps I guess.

-- 
Regards,
Nishanth Menon
