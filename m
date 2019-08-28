From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/11] soc: ti: add OMAP PRM driver (for reset)
Date: Wed, 28 Aug 2019 10:19:30 +0300
Message-ID: <20190828071941.32378-1-t-kristo@ti.com>
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
To: ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

V2 of the series mostly has comments fixed from Suman.
- Added a link between reset + clock drivers to sync up the state between
  these; this is to avoid facing any timeout issues on either end due to
  sequencing of events (Patch #5.) This has been implemented via TI only
  private driver APIs, as at least I am not aware of anybody else needing
  similar mechanism and it is pretty SoC architecture specific.
- Dropped any powerdomain related data for now as it is not used for
  anything yet.
- Added checks against illegal reset IDs.
- Added checks for pdata validity during probe.
- Reset data is added for am4/omap5 SoCs.
- Some other minor tweaks.

This series depends on the clock driver changes [1] due to patch #5,
otherwise there will be build breakage.

Also, just as a background note, this driver has been implemented
under drivers/soc/ti due to the fact that I did not figure out any
better home for it. In its current form it would be suitable to
reside under drivers/reset, but there is a plan to extend this to
support powerdomain handling also (PRM stands for Power and Reset
Management.)

-Tero

[1] https://marc.info/?l=linux-clk&m=156697558331203&w=2


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
