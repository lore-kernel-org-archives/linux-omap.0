From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Date: Mon, 18 Feb 2019 06:44:30 -0800
Message-ID: <20190218144430.GE15711@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190218143629.28392-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com, marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com, vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com, niklas.cassel@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [190218 14:36]:
> Hi,
> 
> cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke the
> ethernet networking on evmsk (and most likely on the evm as well):
> https://patchwork.ozlabs.org/patch/1028527/
> 
> v1 patch to fix the situation:
> https://patchwork.ozlabs.org/patch/1040617/
> 
> It turned out that the at803x driver is actually broken and need to be fixed
> along with the DT data.
> 
> The following series is proposed to fix the driver:
> https://patchwork.ozlabs.org/project/netdev/list/?series=92611
> 
> but the PHT mode needs to be switched to rgmii-id from rgmii-txid:
> The rx delay is enabled by default and the driver never disabled it so when
> asking rgmii-txid it actually got rgmii-id.
> 
> The patch can be backported to stable, I have tested that it is not causing
> regression with the old, broken driver.

Can the dts changes be merged before the driver changes or
does it cause the phy to stop working?

Regards,

Tony
