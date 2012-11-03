From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Sat, 3 Nov 2012 21:24:14 +0530
Message-ID: <50953E26.40906@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab2KCPyW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 11:54:22 -0400
In-Reply-To: <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
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
Whats the intention behind adding OCMRAM ?
Sorry if I missed any comments from the cover letter ?

Regards
Santosh

