From: Giancarlo Canales <gcanales90@gmail.com>
Subject: McSPI Problem on the DM3703
Date: Fri, 31 May 2013 20:30:08 -0400
Message-ID: <CAG748=9cSUazoRtkZ_RHrbpG4A6uihV0HATZZz=UmpdvU3rLnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63891 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3FAAaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 20:30:09 -0400
Received: by mail-vc0-f182.google.com with SMTP id gf12so1505664vcb.27
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 17:30:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Linux OMAP Kernel community,

I've ran into a bit of a pickle when using McSPI on the DM3703. Lets
say that the spi-test (spidev/userspace) program can successfully
generate CLK, SIMO, and CS signals on every SPI (1,2,3) channel you
test it on, but when you go ahead and use a kernel module (like
ENC28J60) through either SPI2 or SPI3, no clock is generated, but you
can still see the SIMO and CS signals. The signs look great when you
use SPI1.

I'm using a 3.0.0 Kernel, and hope that someone can please help me out
with this one.

Thanks
