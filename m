From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/8] ARM/dts: omap2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Fri, 7 Sep 2012 15:29:54 -0700
Message-ID: <20120907222953.GS1303@atomide.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
 <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25171 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755916Ab2IGW34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:29:56 -0400
Content-Disposition: inline
In-Reply-To: <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 04:59]:
> +
> +	ocp {
> +		mcbsp1: mcbsp@48074000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48074000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <59>, /* TX interrupt */
> +				     <60>; /* RX interrupt */
> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp1";
> +		};
> +
> +		mcbsp2: mcbsp@48076000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48076000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <62>, /* TX interrupt */
> +				     <63>; /* RX interrupt */
> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp2";
> +		};
> +	};

Hmm don't you need to specify the interrupt chip and offset for
the interrupts here?

Regards,

Tony
