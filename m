From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 00/10] soc: ti: add OMAP PRM driver (for reset)
Date: Fri, 20 Sep 2019 07:28:49 -0700
Message-ID: <20190920142849.GS5610@atomide.com>
References: <20190912113916.20093-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190912113916.20093-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190912 04:39]:
> Hi,
> 
> V5 of the series, re-sent the whole series as one patch was dropped.
> Changes compared to v3/v4:
> 
> - removed dependency towards clock driver (patch #5 was completely
>   dropped compared to v3/v4)
> - dropped clocks property from dt binding
> - re-added the pdata patch which was accidentally dropped out (it has
>   dependency towards this series.)
> 
> The new implementation (without clock driver dependency) relies on the
> bus driver to sequence events properly, otherwise some timeouts will
> occur either at clock driver or reset driver end.

With the two updated patches seems like we're done with this
series?

If so, I suggest either Santosh or me sets up an immutable
branch against v5.3 or v5.4-rc1 that we all can merge in.
I will need it for the related dts changes at least.

Regards,

Tony
