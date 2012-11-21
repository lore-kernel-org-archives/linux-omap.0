From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH RESEND 02/10] ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
Date: Wed, 21 Nov 2012 09:58:15 +0100
Message-ID: <87624zjpso.fsf@dell.be.48ers.dk>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
	<1352209718-5586-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35922 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2KUI6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 03:58:18 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so1392326wer.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Nov 2012 00:58:17 -0800 (PST)
In-Reply-To: <1352209718-5586-3-git-send-email-anilkumar@ti.com> (AnilKumar
	Ch's message of "Tue, 6 Nov 2012 19:18:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org

>>>>> "A" == AnilKumar Ch <anilkumar@ti.com> writes:

 A> Add matrix keypad device tree data to am335x-evm by adding all
 A> the necessary parameters like keymap, row & column gpios and etc.

 A> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
 A> ---
 A>  arch/arm/boot/dts/am335x-evm.dts |   20 ++++++++++++++++++++
 A>  1 file changed, 20 insertions(+)

 A> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
 A> index 9199456..8076e66 100644
 A> --- a/arch/arm/boot/dts/am335x-evm.dts
 A> +++ b/arch/arm/boot/dts/am335x-evm.dts
 A> @@ -110,6 +110,26 @@
 A>  		regulator-name = "lis3_reg";
 A>  		regulator-boot-on;
 A>  	};
 A> +
 A> +	matrix_keypad: matrix_keypad@0 {
 A> +		compatible = "gpio-matrix-keypad";
 A> +		debounce-delay-ms = <5>;
 A> +		col-scan-delay-us = <2>;
 A> +
 A> +		row-gpios = <&gpio2 25 0	/* Bank1, pin25 */
 A> +			     &gpio2 26 0	/* Bank1, pin26 */
 A> +			     &gpio2 27 0>;	/* Bank1, pin27 */

Sigh, can we PLEASE change am33xx.dtsi to use zero based index like the
TRM and get rid of this madness?

-- 
Bye, Peter Korsgaard
