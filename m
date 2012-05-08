From: Michael Crowe <michael.crowe@compunetix.com>
Subject: OMAP3 EVM kernel
Date: Tue, 8 May 2012 13:36:47 +0000
Message-ID: <1F1FC0DBF7F44B49B17A82F8FDE9635C1E2909@EXCH2.compunet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exch1.compunetix.com ([198.144.40.9]:43045 "EHLO
	exch1.compunetix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab2EHNl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:41:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm attempting to build a linux kernel (3.4-rc4) for the AM/DM37x Evaluation Module.   I built my own cross tools using CrossTools-ng (gcc4.4.3, glibc2.9, binutils2.21.1a).  I am using the bootloader that came on the board and booting from the mmc card.  Below is the output I get at startup.  

Should I be attempting this from the tmlind git tree instead of stable?  

Could someone send me a .config file from a known working kernel?  I am dreadfully ignorant about ARM processors, having spent the last 12 years as a PPC guy.  I now have this ARM eval kit sitting on my desk that I really need to get working in short order.  :)

Thanks,
--Mike


<output>
Texas Instruments X-Loader 1.46 (Aug 16 2010 - 08:13:53)
Starting X-loader on MMC
Reading boot sector

212880 Bytes Read from MMC
Starting OS Bootloader from MMC...
Starting OS Bootloader...


U-Boot 2009.11 (Aug 16 2010 - 09:35:30)

AM37x/DM37x-GP ES2.1, CPU-OPP2 L3-165MHz
OMAP3 EVM board + LPDDR/NAND
I2C:   ready
DRAM:  256 MB
NAND:  512 MiB
In:    serial
Out:   serial
Err:   serial
Read back SMSC id 0x92200000
Die ID #1f6800029ff80000015f26ad0f022014
Net:   smc911x-0                                                                 
Hit any key to stop autoboot:  0                                                 
mmc1 is available                                                                
reading boot.scr                                                                 
                                                                                 
307 bytes read                                                                   
Running bootscript from mmc ...                                                  
## Executing script at 82000000                                                  
reading uImage                                                                   
                                                                                 
3944336 bytes read                                                               
## Booting kernel from Legacy Image at 80200000 ...                              
   Image Name:   Linux-3.4.0-rc2+                                                
   Image Type:   ARM Linux Kernel Image (uncompressed)                           
   Data Size:    3944272 Bytes =  3.8 MB                                         
   Load Address: 80008000                                                        
   Entry Point:  80008000                                                        
   Verifying Checksum ... OK                                                     
   Loading Kernel Image ... OK                                                   
OK                                                                               
                                                                                 
Starting kernel ...                                                              
                                                                                 
Uncompressing Linux... done, booting the kernel.


</output>



