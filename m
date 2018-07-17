From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
Date: Tue, 17 Jul 2018 09:20:28 +0200
Message-ID: <20180717072028.GA3100@piout.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Koen,

I'm not sure how you expect that to be merged but you should probably
send this patch to the TI maintainers along 2/2 because probably no one
in copy of this patch will apply it.

On 17/07/2018 08:24:45+0200, Koen Kooi wrote:
> Add vendor prefix for Sancloud Ltd.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> v5: No changes
> v4: Add Acked-by
> v3: No changes
> v2: No changes
> v1: Initial submission
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7cad066..c7aaa1f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
>  roofull	Shenzhen Roofull Technology Co, Ltd
>  samsung	Samsung Semiconductor
>  samtec	Samtec/Softing company
> +sancloud	Sancloud Ltd
>  sandisk	Sandisk Corporation
>  sbs	Smart Battery System
>  schindler	Schindler
> -- 
> 2.0.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
