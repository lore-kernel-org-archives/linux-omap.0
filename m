From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Wed, 25 Jul 2012 16:43:40 +0400
Message-ID: <500FE9FC.7070303@mvista.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com> <1343219012-19472-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39132 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755483Ab2GYMof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:44:35 -0400
Received: by lahd3 with SMTP id d3so501027lah.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:44:34 -0700 (PDT)
In-Reply-To: <1343219012-19472-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, mkl@pengutronix.de, wg@grandegger.com, linux-arm-kernel@lists.infradead.org

Hello.

On 25-07-2012 16:23, AnilKumar Ch wrote:

> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
> by adding d_can device node with all the necessary parameters.

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9b974dc..2db2ffb 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -163,5 +163,10 @@
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c3";
>   		};
> +
> +		dcan1: d_can@481D0000 {

    Address postfix in the node name and no "reg" property?

> +			compatible = "bosch,d_can";
> +			ti,hwmods = "d_can1";
> +		};

WBR, Sergei


