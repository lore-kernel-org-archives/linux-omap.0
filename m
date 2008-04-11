From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] MUSB: Update =?UTF-8?Q?hdrc=5Fcnf=2Eh=20to=20enable=20the=20f?=
 =?UTF-8?Q?ull=20range=20of=20endpoints?=
Date: Fri, 11 Apr 2008 05:10:14 -0500
Message-ID: <e84922a6aef69dc2705b2cac39944fb1@felipebalbi.com>
References: <010C7BAE6783F34D9AC336EE5A01A08805D6502A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58723 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbYDKKKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 06:10:16 -0400
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805D6502A@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, David Brownell <david-b@pacbell.net>



On Fri, 11 Apr 2008 14:41:26 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Updates to the hdrc_cnf.h file to enable the full range of 16 endpoints.
> This patch fixes the "musb_hdrc: invalid ep 8" messages that show up on
> boot.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Nishant Kamat <nskamat@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  hdrc_cnf.h |   70
> ++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 51 insertions(+), 19 deletions(-)
> 
> Index: linux-omap-2.6/include/asm-arm/arch-omap/hdrc_cnf.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/hdrc_cnf.h	2008-04-08
> 12:36:41.000000000 +0530
> +++ linux-omap-2.6/include/asm-arm/arch-omap/hdrc_cnf.h	2007-08-10
> 17:41:16.000000000 +0530
> @@ -14,11 +14,11 @@
>  
>  /* ** Number of Tx endpoints ** */
>  /* Legal values are 1 - 16 (this value includes EP0) */
> -#define MUSB_C_NUM_EPT 8
> +#define MUSB_C_NUM_EPT 16
>  
>  /* ** Number of Rx endpoints ** */
>  /* Legal values are 1 - 16 (this value includes EP0) */
> -#define MUSB_C_NUM_EPR 8
> +#define MUSB_C_NUM_EPR 16
>  
>  /* ** Endpoint 1 to 15 direction types ** */
>  /* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are
used
> */
> @@ -62,6 +62,38 @@
>  #define MUSB_C_EP7_TX_DEF
>  #define MUSB_C_EP7_RX_DEF
>  #define MUSB_C_EP7_TAR_DEF
> +#define MUSB_C_EP8_DEF
> +#define MUSB_C_EP8_TX_DEF
> +#define MUSB_C_EP8_RX_DEF
> +#define MUSB_C_EP8_TAR_DEF
> +#define MUSB_C_EP9_DEF
> +#define MUSB_C_EP9_TX_DEF
> +#define MUSB_C_EP9_RX_DEF
> +#define MUSB_C_EP9_TAR_DEF
> +#define MUSB_C_EP10_DEF
> +#define MUSB_C_EP10_TX_DEF
> +#define MUSB_C_EP10_RX_DEF
> +#define MUSB_C_EP10_TAR_DEF
> +#define MUSB_C_EP11_DEF
> +#define MUSB_C_EP11_TX_DEF
> +#define MUSB_C_EP11_RX_DEF
> +#define MUSB_C_EP11_TAR_DEF
> +#define MUSB_C_EP12_DEF
> +#define MUSB_C_EP12_TX_DEF
> +#define MUSB_C_EP12_RX_DEF
> +#define MUSB_C_EP12_TAR_DEF
> +#define MUSB_C_EP13_DEF
> +#define MUSB_C_EP13_TX_DEF
> +#define MUSB_C_EP13_RX_DEF
> +#define MUSB_C_EP13_TAR_DEF
> +#define MUSB_C_EP14_DEF
> +#define MUSB_C_EP14_TX_DEF
> +#define MUSB_C_EP14_RX_DEF
> +#define MUSB_C_EP14_TAR_DEF
> +#define MUSB_C_EP15_DEF
> +#define MUSB_C_EP15_TX_DEF
> +#define MUSB_C_EP15_RX_DEF
> +#define MUSB_C_EP15_TAR_DEF
>  
>  /* ** Endpoint 1 to 15 FIFO address bits ** */
>  /* Legal values are 3 to 13 - corresponding to FIFO sizes of 8 to 8192
> bytes. */
> @@ -82,22 +114,22 @@
>  #define MUSB_C_EP6R_BITS 3
>  #define MUSB_C_EP7T_BITS 3
>  #define MUSB_C_EP7R_BITS 3
> -#define MUSB_C_EP8T_BITS 2
> -#define MUSB_C_EP8R_BITS 2
> -#define MUSB_C_EP9T_BITS 2
> -#define MUSB_C_EP9R_BITS 2
> -#define MUSB_C_EP10T_BITS 2
> -#define MUSB_C_EP10R_BITS 2
> -#define MUSB_C_EP11T_BITS 2
> -#define MUSB_C_EP11R_BITS 2
> -#define MUSB_C_EP12T_BITS 2
> -#define MUSB_C_EP12R_BITS 2
> -#define MUSB_C_EP13T_BITS 2
> -#define MUSB_C_EP13R_BITS 2
> -#define MUSB_C_EP14T_BITS 2
> -#define MUSB_C_EP14R_BITS 2
> -#define MUSB_C_EP15T_BITS 2
> -#define MUSB_C_EP15R_BITS 2
> +#define MUSB_C_EP8T_BITS 3
> +#define MUSB_C_EP8R_BITS 3
> +#define MUSB_C_EP9T_BITS 3
> +#define MUSB_C_EP9R_BITS 3
> +#define MUSB_C_EP10T_BITS 3
> +#define MUSB_C_EP10R_BITS 3
> +#define MUSB_C_EP11T_BITS 3
> +#define MUSB_C_EP11R_BITS 3
> +#define MUSB_C_EP12T_BITS 3
> +#define MUSB_C_EP12R_BITS 3
> +#define MUSB_C_EP13T_BITS 3
> +#define MUSB_C_EP13R_BITS 3
> +#define MUSB_C_EP14T_BITS 3
> +#define MUSB_C_EP14R_BITS 3
> +#define MUSB_C_EP15T_BITS 3
> +#define MUSB_C_EP15R_BITS 3
>  
>  /* Define the following constant if the USB2.0 Transceiver Macrocell
data
> width is 16-bits. */
>  /* `define C_UTM_16 */
> @@ -163,7 +195,7 @@
>   * Legal values are 2 - 16
>   * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
>   */
> -#define MUSB_C_NUM_EPS 8
> +#define MUSB_C_NUM_EPS 16
>  
>  /* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits
> */
>  #define MUSB_C_EPMAX_BITS 12
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

