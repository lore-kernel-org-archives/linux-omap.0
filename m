From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 0/4]  mtd: nand: omap: add support for BCH16_ECC
Date: Tue, 20 May 2014 18:05:44 -0700
Message-ID: <20140521010544.GC22233@ld-irv-0074>
References: <1400486082-4345-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55285 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaEUBFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 21:05:48 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so855853pbc.10
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 18:05:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400486082-4345-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>

On Mon, May 19, 2014 at 01:24:38PM +0530, Pekon Gupta wrote:
> As this series touches both linux-mtd and linux-omap (GPMC) sub-systems but in
> independent patch-sets, so looping both maintainers. 'Ack' from maintainers would
> help in getting this series accepted for 3.16
> 
> *changes v3 -> v4*
> [PATCH v4 1/4]: minor update in comments
> [PATCH v4 2/4]: fixed coding style to keep it generic for big/little endianess
> [PATCH v4 3/4]: no change
> [PATCH v4 4/4]: use plain english (non linux stuff)

Pushed all 4 to l2-mtd.git. Thanks!

I have one comment for patch 3, but it's not a blocker.

Brian
