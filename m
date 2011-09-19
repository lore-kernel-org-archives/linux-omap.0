From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] ti816x: add support for nand on ti8168 evm
Date: Mon, 19 Sep 2011 07:56:20 +0300
Message-ID: <1316408187.24366.52.camel@sauron>
References: <parth.saxena@ti.com>
	 <1315486982-30109-1-git-send-email-parth.saxena@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1ISExm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 00:53:42 -0400
Received: by fxe4 with SMTP id 4so3523778fxe.19
        for <linux-omap@vger.kernel.org>; Sun, 18 Sep 2011 21:53:41 -0700 (PDT)
In-Reply-To: <1315486982-30109-1-git-send-email-parth.saxena@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Saxena, Parth" <parth.saxena@ti.com>
Cc: linux-mtd@lists.infradead.org, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, linux-omap@vger.kernel.org

On Thu, 2011-09-08 at 18:33 +0530, Saxena, Parth wrote:
> Add partition table for NAND device on TI8168 EVM
> and initialise the NAND module.
> 
> Signed-off-by: Saxena, Parth <parth.saxena@ti.com>
> Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
> ---
> 
> This patch is tested on top of linux-omap/master and
> Hemant's patches submitted recently.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53457.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg54296.html
> 
>  arch/arm/mach-omap2/board-ti8168evm.c |   39 +++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)

Please, send this patch to Tony, I think it should go in via the omap
tree, not via the MTD tree.

-- 
Best Regards,
Artem Bityutskiy

