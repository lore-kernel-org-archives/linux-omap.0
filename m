From: Rick Bronson <rick@efn.org>
Subject: beagle won't boot.
Date: Fri, 17 Oct 2008 11:52:17 -0700
Message-ID: <E1KquQr-0002qg-Sg@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:53739 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbYJQSwN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Oct 2008 14:52:13 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id D501E170064
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 11:52:12 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KquQr-0002qg-Sg
	for linux-omap@vger.kernel.org; Fri, 17 Oct 2008 11:52:17 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

  I got the lastest code on Oct 16 via:

git clone git://source.mvista.com/git/linux-omap-2.6.git
cd linux-omap-2.6
make omap3_beagle_defconfig
make uImage CROSS_COMPILE="arm-angstrom-linux-gnueabi-" CC="ccache arm-angstrom-linux-gnueabi-gcc-4.2.1+csl-arm-2007q3-53" LD="arm-angstrom-linux-gnueabi-ld"

  and it doesn't seem to want to cooperate with my beagleboard.  As
far as I can tell, it's stuck in

the while loop in omap_start_ehc().  I think because this bit never
got set:

CM_FCLKEN3_CORE->EN_USBTLL (page 472 of the OMAP3 pdf).

  Might have something to do with "usbtll_fck".

  Any help greatly appreciated.

  Thanks,

  Rick
