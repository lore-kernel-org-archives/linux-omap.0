From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] thermal: ti-soc-thermal: Migrate slope/offset
 data to device tree
Date: Thu, 23 Mar 2017 13:52:57 -0700
Message-ID: <20170323205256.GO10760@atomide.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <64ab8413-6cf1-864f-0550-9c8db59523f7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <64ab8413-6cf1-864f-0550-9c8db59523f7@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170321 20:45]:
> 
> 
> On Thursday 09 March 2017 01:35 PM, Keerthy wrote:
> > Currently the slope and offset values for calculating the
> > hot spot temperature of a particular thermal zone is part
> > of driver data. Pass them here instead and obtain the values
> > while of node parsing.
> > 
> > Tested for the slope and constant values on DRA7-EVM, OMAP3-BEAGLE. 
> 
> Hi Eduardo,
> 
> If the series looks okay could you please pull this?

Also.. Are the dts changes safe for me to pick separately?

Regards,

Tony


> > Changes in v2:
> > 
> >   * Added OMAP3 changes along with DRA7/OMAP4/OMAP5.
> > 
> > Keerthy (8):
> >   arm: dts: omap3: Add cpu_thermal zone
> >   ARM: DRA7: Thermal: Add slope and offset values
> >   ARM: OMAP5: Thermal: Add slope and offset values
> >   ARM: OMAP443x: Thermal: Add slope and offset values
> >   ARM: OMAP4460: Thermal: Add slope and offset values
> >   thermal: ti-soc-thermal: Fetch slope and offset from DT
> >   thermal: ti-soc-thermal: Remove redundant constants
> >   thermal: ti-soc-thermal: Remove redundant code
> > 
> >  arch/arm/boot/dts/dra7.dtsi                        |  17 +++
> >  arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |  20 +++
> >  arch/arm/boot/dts/omap34xx.dtsi                    |   8 +-
> >  arch/arm/boot/dts/omap36xx.dtsi                    |   8 +-
> >  arch/arm/boot/dts/omap443x.dtsi                    |   4 +
> >  arch/arm/boot/dts/omap4460.dtsi                    |   4 +
> >  arch/arm/boot/dts/omap5.dtsi                       |   9 ++
> >  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  10 --
> >  .../thermal/ti-soc-thermal/omap3-thermal-data.c    |   4 -
> >  .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   6 -
> >  .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   4 -
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   4 -
> >  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 158 +--------------------
> >  drivers/thermal/ti-soc-thermal/ti-thermal.h        |  16 ---
> >  14 files changed, 71 insertions(+), 201 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap3-cpu-thermal.dtsi
> > 
