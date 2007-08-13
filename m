From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [472/2many] MAINTAINERS - TI OMAP MMC INTERFACE DRIVER
Date: Mon, 13 Aug 2007 12:18:07 +0100
Message-ID: <20070813121807.26014455@the-village.bc.nu>
References: <46bffc14.hGERPpPFcYe9DKoT%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S944908AbXHMOJr@vger.kernel.org>
In-Reply-To: <46bffc14.hGERPpPFcYe9DKoT%joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Sun, 12 Aug 2007 23:37:08 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af16a17..7a7f837 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4478,7 +4478,7 @@ F:	drivers/misc/tifm*
>  F:	drivers/mmc/host/tifm_sd.c
>  
>  TI OMAP MMC INTERFACE DRIVER
> -P:	Carlos Aguiar, Anderson Briglia and Syed Khasim
> +P:	Carlos Aguiar - Anderson Briglia - Syed Khasim

NAK, Please stop sneaking other irrelevant changes into the patchset
