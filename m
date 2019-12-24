From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add omap3-echo
Date: Tue, 24 Dec 2019 10:45:03 -0800
Message-ID: <20191224184503.GK35479@atomide.com>
References: <20191224161005.28083-1-nerv@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191224161005.28083-1-nerv@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>
Cc: webmaster@dawncrow.de, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* André Hentschel <nerv@dawncrow.de> [191224 16:11]:
> This is the first generation Amazon Echo from 2016.
> Audio support is not yet implemented.

OK looks good to me, just worried about one part:

> +&sgx_module {
> +	status = "disabled";
> +};

We should have a separate am3703.dtsi or whatever the SoC model
disabling sgx if not there on the SoC. That way board specific
dts files can just include it without having to debug this issue
over and over.

Regards,

Tony
