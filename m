From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Issue observed with pm_runtime_put_sync
Date: Mon, 18 Oct 2010 13:49:46 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC6139A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab0JRITu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 04:19:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

 
Hi Kevin,
While using pm runtime API's with DMA, it was observed that, during omap_free_dma, 
pm_runtime_put_sync is called which results in warning dump. 
It looks like, when cpu idle patch is under processing, DMA interrupt gets fired 
which inturn call omap_free_dma which results multiple spin_locks.
 
The DMA driver uses *_get_sync during omap_request_dma and *_put_sync during 
omap_free_dma.

Environment:
Kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: master
Commit: 99cf630 Linux-omap rebuilt: Fixed omap4 kernel panic without nosmp, updated to -rc7
+ 
DMA hwmod patches
defconfig: omap2plus_defconfig
board: OMAP3630 Zoom3
 
Is this a known issue or issue with pm runtime API usage in DMA driver?
 
log:
http://pastebin.com/93KPk2ng
 
Regards,
Manjunath 

