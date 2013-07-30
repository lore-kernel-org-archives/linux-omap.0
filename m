From: Chen Baozi <baozich@gmail.com>
Subject: Linux kernel for OMAP5432 uEVM
Date: Tue, 30 Jul 2013 11:38:08 +0800
Message-ID: <20130730033808.GA23486@cbz-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:55159 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab3G3Dnv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 23:43:51 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so5423784pbc.11
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 20:43:50 -0700 (PDT)
Received: from localhost ([119.39.124.170])
        by mx.google.com with ESMTPSA id ry2sm80164839pbc.41.2013.07.29.20.43.48
        for <linux-omap@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 20:43:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm trying to boot my OMAP5432 uEVM devboard with the lastest kernel of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git.
However, after u-boot loading uImage & DTB, there is no output message any
more, such as:

## Executing script at 82000000
reading omap5-evm-omap.dtb
15280 bytes read in 6 ms (2.4 MiB/s)
reading uImage-omap
3996552 bytes read in 250 ms (15.2 MiB/s)
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-3.10.0-rc6-12306-g0dbc346
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3996488 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 825f0000
   Booting using the fdt blob at 0x825f0000
   Loading Kernel Image ... OK
OK
   reserving fdt memory region: addr=9d000000 size=3000000
   Loading Device Tree to 83ff9000, end 83fffbaf ... OK

Starting kernel ...

Before trying this tree, I'm using the 3.8.4 kernel from TI. And it does
support the board and can successfully boot.

Anything that I may have missed when configuring the kernel? I use
omap2plus_defconfig and add DEBUG_LL, DEBUG_OMAP2PLUS_UART,
DEBUG_OMAP4UART3... 

Cheers,

Chen Baozi 
