From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data
 to device tree
Date: Mon, 6 Mar 2017 10:42:16 -0800
Message-ID: <20170306184215.GO20572@atomide.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
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

* Keerthy <j-keerthy@ti.com> [170301 02:31]:
> Currently the slope and offset values for calculating the
> hot spot temperature of a particular thermal zone is part
> of driver data. Pass them here instead and obtain the values
> while of node parsing.
> 
> Tested for the slope and constant values on DRA7-EVM.
> 
> Keerthy (7):
>   ARM: DRA7: Thermal: Add slope and offset values
>   ARM: OMAP5: Thermal: Add slope and offset values
>   ARM: OMAP443x: Thermal: Add slope and offset values
>   ARM: OMAP4460: Thermal: Add slope and offset values
>   thermal: ti-soc-thermal: Fetch slope and offset from DT
>   thermal: ti-soc-thermal: Remove redundant constants
>   thermal: ti-soc-thermal: Remove redundant code

Are the dts changes safe for me to pick separately into
omap-for-v4.12/dt?

Regards,

Tony
