From: Orjan Friberg <of@flatfrog.com>
Subject: OMAP 3730 200 MHz SDRAM config
Date: Mon, 7 Mar 2011 15:46:16 +0100
Message-ID: <4D74EFB8.9030406@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:57777
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751301Ab1CGOvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 09:51:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm looking at configuring an OMAP 3730 board for 200 MHz SDRAM.

I've been looking at the kernel code (arch/arm/mach-omap2) the last
couple of days to try and figure out what I need to do.  We're basing 
ourselves off of the Beagleboard, so I tried copying the 200 MHz Hynix 
SDRAM entry for Beagleboard-xM but that didn't help: it still 
(re)programs the SDRC clock to 166 MHz.

* Does the kernel at all use or depend on the boot loader's SDRAM
config?  (I'm using u-boot with a prepended configuration header.)

* Does the SDRAM setup/clocking depend on the MPU rate at all?  I.e. do
I need to boot Linux in 1 GHz to be able to set 200 MHz SDRC clock?

The clock config is a bit convoluted, so I'd appreciate any help.


Thanks,
Orjan



Appendix:

I'm using a program (user-mode app) called 'bandwidth' (which has an ARM
port):
http://home.comcast.net/~fbui/bandwidth.html for measurements.

With big (several MB) sequential writes I get ~1170 MB/s.  The
theoretical max for a 166 MHz is 166*2 * 4 bytes = 1328 MB/s, so we're
almost at 90%.  We're not the only process accessing memory, and maybe
there's some loss due to SDRAM refresh etc.

-- 
Orjan Friberg
FlatFrog Laboratories AB
