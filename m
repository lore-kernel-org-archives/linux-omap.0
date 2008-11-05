From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] Add touchscreen support for Pandora
Date: Thu, 6 Nov 2008 00:39:21 +0200
Message-ID: <20081105223920.GG4010@frodo>
References: <1225919983-26144-1-git-send-email-notasas@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53587 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYKEWj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 17:39:29 -0500
Content-Disposition: inline
In-Reply-To: <1225919983-26144-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Nov 05, 2008 at 11:19:42PM +0200, Grazvydas Ignotas wrote:
> diff --git a/arch/arm/plat-omap/include/mach/board-omap3pandora.h b/arch/arm/plat-omap/include/mach/board-omap3pandora.h
> new file mode 100644
> index 0000000..bc7f09f
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/board-omap3pandora.h
> @@ -0,0 +1,25 @@
> +/*
> + * board-omap3pandora.h
> + *
> + * Hardware definitions for OMAP3 Pandora.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + */
> +
> +#ifndef __ASM_ARCH_OMAP3_PANDORA_H
> +#define __ASM_ARCH_OMAP3_PANDORA_H
> +
> +#define	OMAP3_PANDORA_TS_GPIO		94

for one define only ???

Do you have plans to add more stuff here ? Do you have any other files
that might need this define besides the main board-file ??

Looks unnecessary to add yet another header for one define only. Moving
to the board-file would be more acceptable.

-- 
balbi
