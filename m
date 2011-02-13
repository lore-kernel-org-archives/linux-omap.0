From: Nishanth Menon <nm@ti.com>
Subject: Re: How to enable dvfs in omap.
Date: Sun, 13 Feb 2011 21:13:42 +0530
Message-ID: <4D57FC2E.3090400@ti.com>
References: <4D5665D4.2030902@e-consystems.com>	<e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com>	<4D566B36.8000008@e-consystems.com>	<4D567436.2090602@ti.com> <AANLkTin3MZNATS4XuY5qU3f7C=f9KogV+1A2_vZTxF-_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37472 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932Ab1BMPnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Feb 2011 10:43:52 -0500
Received: by yxl31 with SMTP id 31so1993131yxl.18
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 07:43:50 -0800 (PST)
In-Reply-To: <AANLkTin3MZNATS4XuY5qU3f7C=f9KogV+1A2_vZTxF-_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kahn, Gery" <geryk@ti.com>
Cc: mohamed@e-consystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, OMAP-KML <linux-omap@vger.kernel.org>

Kahn, Gery wrote, on 02/13/2011 08:39 PM:
> Thank you for the git.
> The pull worked good without problem.
>
> During compilation i found such problem:
>
> arch/arm/plat-omap/cpu-omap.c:142: error: 'struct
' has no
> member named 'loops_per_jiffy'
>
> Is there solution for the issue?
>
Aaah.. one possibility is that you may have disabled CONFIG_SMP in your 
defconfig

well.. baselined to 2.6.38-rc4, it builds fine for me. I am using the 
omap2plus_defconfig
http://pastebin.mozilla.org/1055575 (for output from savedefconfig)

Looking at the source, arch/arm/include/asm/cpu.h
loops_per_jiffy is under CONFIG_SMP and since the omap2plus_defconfig 
builds for OMAP4 as well by default, I am guessing this bug was not 
immediately visible.. You may want to comment on the appropriate patch 
from Vishwa for this. might as well remove the loops_per_jiffy outside 
the CONFIG_SMP

-- 
Regards,
Nishanth Menon
