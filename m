From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC patch] ARM: OMAP: Define OMAP34XX_HS_BASE
Date: Mon, 19 Nov 2007 12:15:35 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711191213050.25712@utopia.booyaka.com>
References: <1195436730-10631-1-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-2-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-3-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-4-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195436730-10631-4-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Mon, 19 Nov 2007, Felipe Balbi wrote:

> Following other omap archs, define OMAP34XX_HS_BASE macro
> to be used later, for example in musb driver.

This #define should go up higher in the omap34xx.h file, so it isn't 
enclosed by CONFIG_ARCH_OMAP34XX.  See for example OMAP3430_CTRL_BASE. 
Trying to get rid of those defines in that conditional block :-)

- Paul

> diff --git a/include/asm-arm/arch-omap/omap34xx.h b/include/asm-arm/arch-omap/omap34xx.h
> index 0265e3b..1650937 100644
> --- a/include/asm-arm/arch-omap/omap34xx.h
> +++ b/include/asm-arm/arch-omap/omap34xx.h
> @@ -71,6 +71,7 @@
>  #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
>  #define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
>  #define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
> +#define OMAP34XX_HS_BASE		(L4_34XX_BASE + 0x65000)
>  #define OMAP2_CONTROL_STATUS		(OMAP2_CTRL_BASE + 0x2f0)
>  
>  #endif
> -- 
> 1.5.3.5.666.gfb5f

- Paul
