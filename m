From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/10] soc: ti: add OMAP PRM driver (for reset)
Date: Thu, 12 Sep 2019 14:39:06 +0300
Message-ID: <20190912113916.20093-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, ssantosh@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org, tony@atomide.com, s-anna@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

V5 of the series, re-sent the whole series as one patch was dropped.
Changes compared to v3/v4:

- removed dependency towards clock driver (patch #5 was completely
  dropped compared to v3/v4)
- dropped clocks property from dt binding
- re-added the pdata patch which was accidentally dropped out (it has
  dependency towards this series.)

The new implementation (without clock driver dependency) relies on the
bus driver to sequence events properly, otherwise some timeouts will
occur either at clock driver or reset driver end.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
