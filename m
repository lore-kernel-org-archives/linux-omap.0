From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Sat, 03 Nov 2012 13:16:06 +0100
Message-ID: <50950B06.8010800@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55528 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab2KCMQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:16:09 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1978173wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 05:16:08 -0700 (PDT)
In-Reply-To: <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Even simple patches need a simple changelog.

Kevin

>   arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..e2cbf24 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -210,5 +210,16 @@
>   			interrupt-parent = <&intc>;
>   			interrupts = <91>;
>   		};
> +
> +		ocmcram: ocmcram@40300000 {
> +			compatible = "ti,ocmcram";
> +			ti,hwmods = "ocmcram";
> +			ti,no_idle_on_suspend;
> +		};
> +
> +		wkup_m3: wkup_m3@44d00000 {
> +			compatible = "ti,wkup_m3";
> +			ti,hwmods = "wkup_m3";
> +		};
>   	};
>   };
>
