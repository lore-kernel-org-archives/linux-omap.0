From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP5: Add VGIC interrupts for KVM
Date: Mon, 16 Sep 2013 19:24:59 -0400
Message-ID: <5237934B.3090705@ti.com>
References: <1379373423-10486-1-git-send-email-alexander.tarasikov@gmail.com> <1379373423-10486-2-git-send-email-alexander.tarasikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379373423-10486-2-git-send-email-alexander.tarasikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Tarasikov <alexander.tarasikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 16 September 2013 07:17 PM, Alexander Tarasikov wrote:
> 	This adds the interrupt configuration for the
> 	Cortex-A15 GIC to make KVM work in HYP mode
> ---
>  arch/arm/boot/dts/omap5.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 07be2cd..8026a4e 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -63,6 +63,7 @@
>  		      <0x48212000 0x1000>,
>  		      <0x48214000 0x2000>,
>  		      <0x48216000 0x2000>;
> +		interrupts = <1 9 0xf04>;
>  	};
>  
>  	/*
> 
Interrupt configuration already exist
but what is missing is the maintenance interrupt.
I was planning to post a patch to add that. Patch
is end of the email. The end result is same as your
patch but more readable and as per the recent clean-up
of dts.

Regards,
Santosh

>From e4aa21948baccc24ad9682e92f7188d5c8d55286 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Date: Thu, 12 Sep 2013 15:53:13 -0400
Subject: [PATCH] ARM: dts: OMAP5: Add maintenance interrupt for
 virtualisation

Add a maintenance IRQ using PPI 9 to OMAP5 device tree
needed for virtualisation.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 07be2cd..6de6148 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -63,6 +63,7 @@
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	/*
-- 
1.7.9.5



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
