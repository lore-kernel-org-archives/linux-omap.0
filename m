From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/1] [ALSA] Remove useless sound/driver.h
Date: Sun, 13 Apr 2008 19:49:21 -0400
Message-ID: <48029C01.5090906@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16787 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbYDMXtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Apr 2008 19:49:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony and folks,

This patch removes useless include/sound/driver.h from sound/arm/omap/ files,
following the Takashi Iwai's commit at Linux-OMAP tree [1].

This removes the following warning during omap_h2_1610_defconfig
building with sound support.

...
  CC      sound/arm/omap/omap-alsa.o
In file included from sound/arm/omap/omap-alsa.c:49:
include/sound/driver.h:1:2: warning: #warning "This file is deprecated"
  CC      sound/arm/omap/omap-alsa-dma.o
...

BR,

Carlos.

[1]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=9004acc70e8c49c50c4c7b652f906f1e0ed5709d

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

