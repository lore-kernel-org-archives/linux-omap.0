From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
Date: Mon, 4 Oct 2010 22:22:50 +0100
Message-ID: <20101004212250.GD25241@n2100.arm.linux.org.uk>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com> <1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32987 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256Ab0JDVXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 17:23:17 -0400
Content-Disposition: inline
In-Reply-To: <1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, tglx@linutronix.de, linux-omap@vger.kernel.org

On Tue, Sep 07, 2010 at 01:27:23PM +0530, Santosh Shilimkar wrote:
> For the big buffers which are in excess of cache size, the maintaince
> operations by PA are very slow. For such buffers the maintainace
> operations can be speeded up by using the WAY based method.

This causes my Versatile Express to corrupt MMC transfers.  Reverting
both this and the 'Determine cache size' patches makes it work again.

(Note that just reverting this one doesn't result in a working situation.)

Good boot:

L310 cache controller enabled                                                   
l2x0: 8 ways, CACHE_ID 0x410000c3, AUX_CTRL 0x02460000                          
...
mmci-pl18x mb:mmci: mmc0: MMCI rev 0 cfg 00 at 0x0000000010005000 irq 41,42     
aaci-pl041 mb:aaci: ARM AC'97 Interface at 0x0000000010004000, irq 43, fifo 512 
ALSA device list:                                                               
  #0: ARM AC'97 Interface at 0x0000000010004000, irq 43                         
TCP cubic registered                                                            
mmc0: host does not support reading read-only switch. assuming write-enable.    
mmc0: new SD card at address e624                                               
mmcblk0: mmc0:e624 SD02G 1.89 GiB                                               
NET: Registered protocol family 17                                              
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0         
 mmcblk0: p1                                                                    
Initalizing network drop monitor service                                        
Waiting 5sec before mounting root device...                                     
port 1 high speed                                                               

Bad boot (with just 'Determine cache size' patch applied):

L310 cache controller enabled                                                   
l2x0: 8 ways, CACHE_ID 0x410000c3, AUX_CTRL 0x02460000, Cache size: 512 KB      
...
mmci-pl18x mb:mmci: mmc0: MMCI rev 0 cfg 00 at 0x0000000010005000 irq 41,42     
aaci-pl041 mb:aaci: ARM AC'97 Interface at 0x0000000010004000, irq 43, fifo 512 
ALSA device list:                                                               
  #0: ARM AC'97 Interface at 0x0000000010004000, irq 43                         
mmc0: host does not support reading read-only switch. assuming write-enable.    
mmc0: new SD card at address e624                                               
mmcblk0: mmc0:e624 SD02G 1.89 GiB                                               
TCP cubic registered                                                            
NET: Registered protocol family 17                                              
mmcblk0: retrying using single block read                                       
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0         
mmcblk0: error -5 transferring data, sector 0, nr 8, card status 0x900          
Initalizing network drop monitor service                                        
<random garbage>
mmcblk0: error -5 transferring data, sector 1, nr 7, card status 0x900
end_request: I/O error, dev mmcblk0, sector 1                                   
Buffer I/O error on device mmcblk0, logical block 0                             
port 1 high speed                                                               

-5 is -EIO, which is a FIFO overrun error, so somehow these changes are
causing the CPU or bus accesses to be slower.
