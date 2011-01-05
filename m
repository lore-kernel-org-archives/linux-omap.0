From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Wed, 05 Jan 2011 07:32:58 -0600
Message-ID: <4D24730A.3050905@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com> <20110103223656.GA8414@n2100.arm.linux.org.uk> <4D22503F.9060100@ti.com> <4D238503.6070103@ti.com> <20110105002549.GA1445@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60533 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101Ab1AENdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 08:33:15 -0500
Received: by mail-gw0-f47.google.com with SMTP id a12so3568422gwa.34
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:33:15 -0800 (PST)
In-Reply-To: <20110105002549.GA1445@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux wrote, on 01/04/2011 06:25 PM:
> On Tue, Jan 04, 2011 at 02:37:23PM -0600, Nishanth Menon wrote:
>> hmm.. minor nit (with codesourcery 2010.09-50 - 4.5.1):
>> rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/ 2>Kerr;make C=2
>> arch/arm/mach-omap2/ 2>Kerr1;diff Kerr Kerr1
>> [..]
>> 1,4d0
>> <  arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_by_name':
>> <  arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used
>> uninitialized in this function
>> <  arch/arm/mach-omap2/clkt_clksel.c: In function 'omap2_clksel_set_parent':
>> <  arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
>> used uninitialized in this function
>>
>> Kinda interesting to note that C=2 does'nt list all potential gcc
>> warnings :( if one wanted a collated list of all warnings, rm .../*.o
>> helps I guess.
>
> C=2 only runs sparse - so if you're committing patches to fix sparse
> warnings, that's what you should be interested in.
>
> I'd suggest that fixing sparse warnings and GCC warnings in a single
> patch is probably not the best thing to do - GCC warnings are less
> subjective than sparse warnings.
I agree.

-- 
Regards,
Nishanth Menon
