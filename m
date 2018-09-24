From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: add pulldown/up settings for
 twl4030 gpio
Date: Mon, 24 Sep 2018 15:11:02 -0700
Message-ID: <20180924221102.GK5662@atomide.com>
References: <20180924172957.20366-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924172957.20366-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180924 10:34]:
> Pullup and down settings were missing, so add them to avoid
> floating pins and make headset detection working.

Applying into omap-for-v4.20/dt thanks.

Tony
