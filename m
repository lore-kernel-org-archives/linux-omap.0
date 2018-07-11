From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Wed, 11 Jul 2018 06:31:37 -0700
Message-ID: <20180711133137.GM99251@atomide.com>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
> +&cpu0_opp_table {
> +	/*
> +	 * All PG 2.0 silicon may not support 1GHz but some of the early
> +	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
> +	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
> +	 */
> +	oppnitro-1000000000 {
> +		opp-supported-hw = <0x06 0x0100>;
> +	};
> +};

Is the above valid for new boards or should it be just
dropped? Or is the comment just out of date?

Regards,

Tony
