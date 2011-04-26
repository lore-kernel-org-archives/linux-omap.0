From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: enable interface for omap4
Date: Tue, 26 Apr 2011 10:18:10 +0300
Message-ID: <1303802290.2084.14.camel@deskari>
References: <1303356675-25451-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34567 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757687Ab1DZHSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 03:18:17 -0400
Received: by eyg5 with SMTP id 5so131503eyg.24
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 00:18:14 -0700 (PDT)
In-Reply-To: <1303356675-25451-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On Wed, 2011-04-20 at 20:31 -0700, Vikram Pandita wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> By default, the DSI is not getting enabled for omap4.
> OMAP2PLUS does not catch this issue since it has ARCH_OMAP3.
> 
> The issue is only seen when using defconfig with ARCH_OMAP4 only.
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Archit Taneja <archit@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.

 Tomi


