From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
Date: Wed, 23 May 2012 10:48:03 -0700
Message-ID: <20120523174803.GA18609@codeaurora.org>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321615040-13257-2-git-send-email-rnayak@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, robherring2@gmail.com, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 18, 2011 at 04:47:17PM +0530, Rajendra Nayak wrote:

> +	xyzreg: regulator@0 {
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};

Just noticed this, but the '@0' shouldn't be on the name, since there
isn't a reg attribute on this node.  Perhaps it should be
"regulator-xyz"?

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
