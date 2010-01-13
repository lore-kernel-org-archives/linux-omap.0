From: Tony Lindgren <tony@atomide.com>
Subject: Re: LDP broken?
Date: Wed, 13 Jan 2010 09:33:37 -0800
Message-ID: <20100113173337.GI2986@atomide.com>
References: <20100113134007.GB28292@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62031 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab0AMRdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 12:33:37 -0500
Content-Disposition: inline
In-Reply-To: <20100113134007.GB28292@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100113 05:39]:
> While trying to boot the latest kernel on the LDP platform, it appears
> that MMC has a problem.
> 
> Unfortunately, being a small form factor card, the only platform I have
> which accepts it is the LDP.  Not sure if this is down to crappyness
> with the card or the host driver.
> 
> Waiting 2sec before mounting root device...                                     
> mmc0: host does not support reading read-only switch. assuming write-enable.    
> mmc0: new high speed SD card at address 0002                                    
> mmcblk0: mmc0:0002 00000 971 MiB                                                
>  mmcblk0: p1 p2                                                                 
> kjournald starting.  Commit interval 5 seconds                                  
> EXT3-fs (mmcblk0p2): warning: mounting fs with errors, running e2fsck is recomme
> nded                                                                            
> EXT3-fs (mmcblk0p2): using internal journal                                     
> EXT3-fs (mmcblk0p2): recovery complete                                          
> EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode                
> VFS: Mounted root (ext3 filesystem) on device 179:2.                            
> Freeing init memory: 108K                                                       
> mmcblk0: retrying using single block read                                       
> mmcblk0: retrying using single block read                                       
> INIT: version 2.86 booting                                                      
> mmcblk0: retrying using single block read                                       
> mmcblk0: retrying using single block read                                       
> modprobe: FATAL: Could not load /lib/modules/2.6.33-rc4/modules.dep: No such fil
> e or directory                                                                  
>                                                                                 
> modprobe: FATAL: Could not load /lib/modules/2.6.33-rc4/modules.dep: No such fil
> e or directory                                                                  
>                                                                                 
> Error opening /dev/fb0: No such device or address                               
> udev requires hotplug support, not started.                                     
> mmcblk0: retrying using single block read                                       
> WARNING: Couldn't open directory /lib/modules/2.6.33-rc4: No such file or direct
> ory                                                                             
> FATAL: Could not open /lib/modules/2.6.33-rc4/modules.dep.temp for writing: No s
> uch file or directory                                                           
> modprobe: FATAL: Could not load /lib/modules/2.6.33-rc4/modules.dep: No such fil
> e or directory                                                                  
>                                                                                 
> modprobe: FATAL: Could not load /lib/modules/2.6.33-rc4/modules.dep: No such fil
> e or directory                                                                  
>                                                                                 
> mmcblk0: error -110 transferring data, sector 149929, nr 216, card status 0xc00 
> end_request: I/O error, dev mmcblk0, sector 150100                              
> end_request: I/O error, dev mmcblk0, sector 150105                              
> end_request: I/O error, dev mmcblk0, sector 150113                              
> end_request: I/O error, dev mmcblk0, sector 150121                              
> end_request: I/O error, dev mmcblk0, sector 150129                              
> end_request: I/O error, dev mmcblk0, sector 150137                              
> Aborting journal on device mmcblk0p2.                                           
> EXT3-fs (mmcblk0p2): error in ext3_reserve_inode_write: Journal has aborted     
> EXT3-fs (mmcblk0p2): error in ext3_dirty_inode: Journal has aborted             
> EXT3-fs (mmcblk0p2): error: ext3_journal_start_sb: Detected aborted journal     
> EXT3-fs (mmcblk0p2): error: remounting filesystem read-only                     
> Setting up IP spoofing protection: FAILED.                                      
> Configuring network interfaces... done.                                         
> Starting portmap daemon: portmap.                                               
> mmcblk0: retrying using single block read                                       
> /sbin/ldconfig: /usr/lib/libts-0.0.so.0 is not a symbolic link                  
> ...

It looks like .wires = 4 is should be a safe setting. Maybe the 
card is broken or does not get enough power from twl? No LDP here,
but MMC is working OK in general for me.

Regards,

Tony

