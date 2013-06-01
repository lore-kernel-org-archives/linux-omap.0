From: Giancarlo Canales <gcanales90@gmail.com>
Subject: McSPI Problem on the DM3703
Date: Fri, 31 May 2013 20:22:14 -0400
Message-ID: <F1FD267A-08E8-4364-9389-4B6C4664A73D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:54697 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab3FAAWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 20:22:17 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so1602774veb.31
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 17:22:16 -0700 (PDT)
Received: from lattice.home (pool-71-255-247-179.washdc.fios.verizon.net. [71.255.247.179])
        by mx.google.com with ESMTPSA id s9sm37967226vdh.4.2013.05.31.17.22.15
        for <linux-omap@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 17:22:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Linux OMAP Kernel community,

I've ran into a bit of a pickle when using McSPI on the DM3703. Lets say that the spi-test (spidev/userspace) program can successfully generate 
CLK, SIMO, and CS signals on every SPI (1,2,3) channel you test it on, but when you go ahead and use a kernel module (like ENC28J60) through
either SPI2 or SPI3, no clock is generated, but you can still see the SIMO and CS signals. The signs look great when you use SPI1.

I'm using a 3.0.0 Kernel, and hope that someone can please help me out with this one.

Thanks
