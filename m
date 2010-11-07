From: Rick Bronson <rick@efn.org>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Sun, 07 Nov 2010 07:44:40 -0800
Message-ID: <E1PF7Q8-0004IQ-8y@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:48089 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab0KGPol (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 10:44:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: srinath@mistralsolutions.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

sanjeev,

  Thanks much for the help.

> [sp] On first looks I would suspect the u-boot. 2009.11 seems to be quite old.
>      Can you try using version 2010.09?

  I had tried 2010.09 on this board originally but found that it
wasn't stable, it was almost like the SDRAM wasn't set up correctly.
I'd get random panic's on bad pointers in Linux.  But I tried it
anyway on this new kernel and it does set up the networking about 1 in
5 boots.  Here is a boot where it set up the network
http://www.efn.org/~rick/pub/boot4.log, it still has the warnings though.

  Please check my setup of u-boot, here is what I did:

wget ftp://ftp.denx.de/pub/u-boot/u-boot-2010.09.tar.bz2
tar jxf u-boot-2010.09.tar.bz2
cd u-boot-2010.09; make omap3_evm_config; make

  Is this the correct config (omap3_evm_config) to use for this board?
Maybe you could tell me what exact u-boot and kernel you'd recommend
and the steps to get them for this board.

  Thanks,

  Rick
