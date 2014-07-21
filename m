From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v3 PATCH 2/6] dt: TI: Describe the ti reset DT entries
Date: Mon, 21 Jul 2014 00:01:25 -0700
Message-ID: <20140721070125.GM18374@atomide.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
 <1405615531-15649-2-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25999 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752921AbaGUHCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 03:02:50 -0400
Content-Disposition: inline
In-Reply-To: <1405615531-15649-2-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [140717 09:47]:
> +
> +example:
> +		prm: prm@4ae06000 {
> +			compatible = "ti,omap5-prm";
> +			reg = <0x4ae06000 0x3000>;
> +
> +			prm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#reset-cells = <1>;
> +			};
> +		};

Probably the way to go with mapping various PRCM registers to separate
drivers is to provide one or more syscon entries like we already have
for the SCM. You may want to coordinate this with Tero.

Regards,

Tony
