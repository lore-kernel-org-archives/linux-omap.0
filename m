From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Date: Thu, 4 Apr 2019 07:11:09 -0700
Message-ID: <20190404141108.GC49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
 <20190401175245.GJ49658@atomide.com>
 <20190401203854.3b6ec1a2@kemnade.info>
 <20190401204033.GK49658@atomide.com>
 <20190404125111.3800e26d@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190404125111.3800e26d@kemnade.info>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, Keerthy <j-keerthy@ti.com>, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190404 10:53]:
> On Mon, 1 Apr 2019 13:40:33 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190401 18:39]:
> > > Could we somehow describe this property of the hardware
> > > (is-offmode-capable or is-wired-for-offmode) as a separate devicetree
> > > property of the soc?
> > > 
> > > In mmc we have for example "cap-power-off-card" for
> > > indicating some is-wired-suitable-for thing.  
> > 
> > And we also have "regulator-off-in-suspend".
> > 
> > How about "soc-off-in-suspend" for the generic name?
> > 
> Well, remember my "omap3: give off mode enable a more prominent place"
> maybe we can use the same  capability property for both proposes.

Yes. I don't think we need a Kconfig option for it though.
Seems just a device specific property should be enough for now.

Regards,

Tony
