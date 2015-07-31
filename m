From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
Date: Fri, 31 Jul 2015 19:18:20 +0530
Message-ID: <55BB7CA4.1020300@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com> <1438072876-16338-5-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438072876-16338-5-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 28 July 2015 02:11 PM, Vignesh R wrote:
> Add qspi memory mapped region entries for DRA7xx based SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index ade28c790f4b..5317a0f24ab9 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi

The patch talks about DRA7x in subject and description but you modify
AM437x here. You have got commit text mixed up between 4/5 and 5/5.

Probably not the kind of feedback you are looking for an RFC, but since
I noticed it..

Thanks,
Sekhar
