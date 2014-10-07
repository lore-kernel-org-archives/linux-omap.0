From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/2] mtd: nand: omap: Fix build with
 CONFIG_MTD_NAND_OMAP_BCH=m
Date: Mon, 6 Oct 2014 23:44:04 -0700
Message-ID: <20141007064404.GA22169@norris-Latitude-E6410>
References: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:38033 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaJGGoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2014 02:44:17 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so4591746pdb.30
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2014 23:44:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ezequiel.garcia@free-electrons.com, pekon@pek-sem.com, arnd@arndb.de, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Oct 01, 2014 at 02:33:28PM +0300, Roger Quadros wrote:
> Hi,
> 
> Patch 1 fixes build with OMAP nand driver as built-in and the BCH driver as a module.
> Ezequiel, I took the liberty to address an issue with your original patch so this is v2.
> 
> Patch 2 fixes the help message for CONFIG_MTD_NAND_OMAP_BCH to avoid user confusion.
> CONFIG_MTD_NAND_OMAP_BCH is optional but doesn't harm on legacy OMAP platforms not having
> the ELM/BCH hardware.

Thanks for finishing these off properly. Pushed to l2-mtd.git.

Briarn
