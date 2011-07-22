From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2] MTD: Nand: use MTD_NAND_OMAP2 for OMAP4
Date: Fri, 22 Jul 2011 10:58:42 +0300
Message-ID: <1311321527.20707.6.camel@sauron>
References: <1311137590.20738.135.camel@sauron>
	 <1311146884-22255-1-git-send-email-j.weitzel@phytec.de>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64874 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1GVH51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jul 2011 03:57:27 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so1717800iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 00:57:27 -0700 (PDT)
In-Reply-To: <1311146884-22255-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Artem.Bityutskiy@nokia.com, vimalsingh@ti.com

On Wed, 2011-07-20 at 09:28 +0200, Jan Weitzel wrote:
> use MTD_NAND_OMAP2 also for OMAP4 arch.
> testes wit omap4430
> 
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
> v2: add menuconfig description

Pushed to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy

