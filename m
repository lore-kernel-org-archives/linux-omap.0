From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 16/20] Get DISPC base addr with platform device
Date: Wed, 25 Aug 2010 16:13:04 +0300
Message-ID: <1282741984.9299.223.camel@tubuntu.research.nokia.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	 <1282579089-10487-2-git-send-email-svadivu@ti.com>
	 <1282579089-10487-3-git-send-email-svadivu@ti.com>
	 <1282579089-10487-4-git-send-email-svadivu@ti.com>
	 <1282579089-10487-5-git-send-email-svadivu@ti.com>
	 <1282579089-10487-6-git-send-email-svadivu@ti.com>
	 <1282579089-10487-7-git-send-email-svadivu@ti.com>
	 <1282579089-10487-8-git-send-email-svadivu@ti.com>
	 <1282579089-10487-9-git-send-email-svadivu@ti.com>
	 <1282579089-10487-10-git-send-email-svadivu@ti.com>
	 <1282579089-10487-11-git-send-email-svadivu@ti.com>
	 <1282579089-10487-12-git-send-email-svadivu@ti.com>
	 <1282579089-10487-13-git-send-email-svadivu@ti.com>
	 <1282579089-10487-14-git-send-email-svadivu@ti.com>
	 <1282579089-10487-15-git-send-email-svadivu@ti.com>
	 <1282579089-10487-16-git-send-email-svadivu@ti.com>
	 <1282579089-10487-17-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32706 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0HYNNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 09:13:16 -0400
In-Reply-To: <1282579089-10487-17-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@ti.com" <khilman@ti.com>

On Mon, 2010-08-23 at 17:58 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> DISPC Base addr got from the platform device.  Hadrcoding of base
> addr removed.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index ae18b5f..8a7a086 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -40,7 +40,6 @@
>  #include "dss.h"
>  
>  /* DISPC */
> -#define DISPC_BASE			0x48050400
>  
>  #define DISPC_SZ_REGS			SZ_1K

I guess *_SZ_REGS are not needed anymore for any of the blocks.

 Tomi


