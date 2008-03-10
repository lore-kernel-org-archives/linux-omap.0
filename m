From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems booting Filesystem
Date: Mon, 10 Mar 2008 22:53:01 +0200
Message-ID: <20080310205258.GG4459@kedavra.cpe.vivax.com.br>
References: <ae36f8040803101227i6be46d20y6bbc49b06deb4f7d@mail.gmail.com> <20080310201849.GF4459@kedavra.cpe.vivax.com.br> <ae36f8040803101319r74d2ec97g2c0444358ce6254@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43329 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYCJUut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 16:50:49 -0400
Content-Disposition: inline
In-Reply-To: <ae36f8040803101319r74d2ec97g2c0444358ce6254@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lu?s Vit?rio Cargnini <lvcargnini@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 10, 2008 at 05:19:17PM -0300, Lu?s Vit?rio Cargnini wrote:
> I attached the config, no I only add a new driver, that is under
> beta-test (again), because I'm adding new analogic channels control
> capability to the driver (I control only on analogic channel before),
> that is it.

Please don't top post :-S
also, you forgot to Cc the list, this answer is also going to the list
;-)

According to your defconfig you should be mounting fs in a ramdisk, is
this right or are you flashing in onenand?

Besides you don't have nand support built.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
