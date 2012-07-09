From: Tony Lindgren <tony@atomide.com>
Subject: Re: dtb for pandaboard
Date: Mon, 9 Jul 2012 02:08:49 -0700
Message-ID: <20120709090848.GD1122@atomide.com>
References: <20120708173259.592552c1@pegasus.ausil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab2GIJIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 05:08:52 -0400
Content-Disposition: inline
In-Reply-To: <20120708173259.592552c1@pegasus.ausil.us>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dennis Gilmore <dennis@ausil.us>
Cc: linux-omap@vger.kernel.org

* Dennis Gilmore <dennis@ausil.us> [120708 16:11]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi does anyone happen to have a working dtb file for the pandaboard?
> trying to test booting the fedora rawhide kernel which is
> 3.5.0-rc5 with a dtb file I made from the matching sources I dont get
> past decompressing the kernel. if i dont use a dtb file the system
> boots further but it i'm unable to find the root filesystem since it
> seems that the platform data has been messed up. modprobing omap
> results in no registration of the mmc block devices. 
> 
> i've not tested on a pandaboard ES or beagleboard yet  or any other
> type of omap system. 

FYI, I booted my panda es recently just fine with dtb append support
and the following .config addition using the plain
arch/arm/boot/dts/omap4-panda.dts file:

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_EXT4_FS=y

Can you please enable DEBUG_LL, EARLY_PRINTK and add earlyprintk to
your cmdline and post what you get?

Regards,

Tony
