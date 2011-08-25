From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: Question on virtual memory layout: lowmem with memory hole
Date: Thu, 25 Aug 2011 09:35:07 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E23FC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39384 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728Ab1HYEFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 00:05:16 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Pedanekar, Hemant" <hemantp@ti.com>

Hello,

While checking with memory hole configuration on OMAP3/TI816X (passing mem=x@y),
I see that the whole range from memory start till last bank including the hole
is labelled as 'lowmem' when kernel prints "Virtual kernel memory layout" during
boot.

E.g., on OMAP3 with mem=32M@0x80000000 mem=8M@0x87800000

(CASE 1)
 Memory: 32MB 8MB = 40MB total
 Memory: 28408k/28408k available, 12552k reserved, 0K highmem
 Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc05ac2c8   (5777 kB)
       .init : 0xc05ad000 - 0xc05f8780   ( 302 kB)
       .data : 0xc05fa000 - 0xc06838d0   ( 551 kB)
        .bss : 0xc06838f4 - 0xc0bd8a14   (5461 kB)

Is this expected? 88MB space between two 'mem's seems to have lost. This also
means vmalloc space is lower compared to when a single mem=40M is passed.

E.g., with mem=40M

(CASE 2)
 Memory: 40MB = 40MB total
 Memory: 28412k/28412k available, 12548k reserved, 0K highmem
 Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
     vmalloc : 0xc3000000 - 0xf8000000   ( 848 MB)
     lowmem  : 0xc0000000 - 0xc2800000   (  40 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc05ac2c8   (5777 kB)
       .init : 0xc05ad000 - 0xc05f8780   ( 302 kB)
       .data : 0xc05fa000 - 0xc06838d0   ( 551 kB)
        .bss : 0xc06838f4 - 0xc0bd8a14   (5461 kB)

Any way we can get virtual layout same in CASE 1 as in CASE 2?

Thanks.

   Hemant