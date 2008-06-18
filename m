From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC/PATCH  1/4] McBSP support  for 34XX
Date: Wed, 18 Jun 2008 10:23:07 +0300
Message-ID: <20080618102307.95d99f49.jarkko.nikula@nokia.com>
References: <003b01c8cfab$6f16edb0$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50749 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYFRHXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 03:23:20 -0400
In-Reply-To: <003b01c8cfab$6f16edb0$318918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 16 Jun 2008 17:50:58 +0530
"ext Chandra shekhar" <x0044955@ti.com> wrote:

> 
> Signed-off-by: chandra shekhar <x0044955@ti.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |    1 
>  arch/arm/mach-omap2/mcbsp.c             |   45 ++++++++++++++++++++++
> ++++++++++ arch/arm/plat-omap/mcbsp.c              |    2 -
>  include/asm-arm/arch-omap/mcbsp.h       |   34 +++++++++++++++++++++
> +-- 4 files changed, 79 insertions(+), 3 deletions(-)
...
> +#define OMAP_MCBSP_BIT(ARG)	((0x01)<<(ARG))
>  
> +#define DILB			OMAP_MCBSP_BIT(5)
> 
This OMAP_MCBSP_BIT(ARG) is needless. Usual (1 << 5) convention would
be better or follow the same 0x0020 convention what mcbsp.h is doing
currently.


Jarkko
