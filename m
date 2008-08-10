From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: omap24xx is broken in current head
Date: Sun, 10 Aug 2008 14:31:05 +0200
Message-ID: <489EDF89.4070606@googlemail.com>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:36986 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYHJMbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Aug 2008 08:31:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so848260fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 10 Aug 2008 05:31:10 -0700 (PDT)
In-Reply-To: <20080810121655.GH7574@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Sun, Aug 10, 2008 at 02:58:19PM +0300, Felipe Balbi wrote:
> 
>><5>Kernel command line: root=1f03 rootfstype=jffs2
>><6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
>><1>Unhandled fault: alignment exception (0x001) at 0xc02c1b4e
> 
> 
> Reverting commit 718fc6cd4db902aa2242a736cc3feb8744a4c71a, looks like
> gcc is not being able to align that union ??
> 
> I'm using codesourcery 2008q1-126 (gcc 4.2.3)
> 
> Did you guys have any problems with this version of CS ??

For OMAP3/Cortex-A8 at least some issues are known with 2008q1:

*  Vectorization + NEON is broken
* building static binaries with cortex-a8 flag (or any ARMv7a core) is 
broken
* some armv6 compilations end in ICE

Therefore, for Beagle & friends we recommend 2007q3. This has a known 
issue with -Os option, though.

Dirk

