From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] ARM: omap2plus_defconfig updates
Date: Thu, 16 Jul 2015 00:56:27 -0700
Message-ID: <20150716075627.GJ17550@atomide.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [150708 08:30]:
> Hi Tony,
> 
> Here are some defconfig updates for commonly
> used drivers on platforms supported by
> omap2plus_defconfig.
> 
> Applies to v4.2-rc1
> 
> Thanks,
> Sekhar
> 
> Sekhar Nori (4):
>   ARM: omap2plus_defconfig: enable support for TI ADC
>   ARM: omap2plus_defconfig: enable support for TI touchscreen
>   ARM: omap2plus_defconfig: enable support for TI CPTS
>   ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR
> 
>  arch/arm/configs/omap2plus_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)

Applying all into omap-for-v4.3/defconfig thanks.

Tony
