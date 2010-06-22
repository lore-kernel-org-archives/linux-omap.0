From: Neshama Parhoti <pneshama@gmail.com>
Subject: ZOOM2 doesn't boot on upstream kernel
Date: Tue, 22 Jun 2010 21:41:48 +0300
Message-ID: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0FVSlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 14:41:50 -0400
Received: by bwz9 with SMTP id 9so150384bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 11:41:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I can't get to boot the latest mainline kernel on ZOOM2 (using
omap_zoom2_defconfig).

It just hangs after u-boot is saying "loading kernel...".

I know that my setup is ok, because if I use TI kernel sources from my
BSP it boots fine..

Any idea what is the problem ?

Maybe I need to use also recent upstream u-boot ?

thank you
~pnesh
