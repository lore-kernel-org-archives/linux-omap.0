From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: doc: Document missing compatible property
 for omap-sham driver
Date: Thu, 14 Nov 2013 10:59:16 -0800
Message-ID: <20131114185916.GS10317@atomide.com>
References: <1383889056-17336-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383889056-17336-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: devicetree@vger.kernel.org, santosh.shilimkar@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, rob@landley.net, bcousson@baylibre.com, linux-doc@vger.kernel.org, joelf@ti.com
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [131107 21:38]:
> A new compatible property "ti,omap5-sham" is added to the omap-sham driver
> recently to support SHA/MD5 for OMAP5,DRA7 and AM43XX. Documenting the
> same.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks applying into omap-for-v3.13/fixes.

Tony

> ---
>  .../devicetree/bindings/crypto/omap-sham.txt       |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
> index f839acd..ad91155 100644
> --- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
> +++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
> @@ -6,7 +6,7 @@ Required properties:
>    SHAM versions:
>    - "ti,omap2-sham" for OMAP2 & OMAP3.
>    - "ti,omap4-sham" for OMAP4 and AM33XX.
> -  Note that these two versions are incompatible.
> +  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
>  - ti,hwmods: Name of the hwmod associated with the SHAM module
>  - reg : Offset and length of the register set for the module
>  - interrupts : the interrupt-specifier for the SHAM module.
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
