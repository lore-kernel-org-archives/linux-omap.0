From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/16] ARM: OMAP2+: Drop legacy platform data for am3 and
 am4 rtc
Date: Fri, 13 Dec 2019 06:59:26 -0800
Message-ID: <20191213145926.GI35479@atomide.com>
References: <20191211172014.35201-1-tony@atomide.com>
 <20191211172014.35201-13-tony@atomide.com>
 <422c4d8d-27e3-7055-e8a4-c830a7e569be@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <422c4d8d-27e3-7055-e8a4-c830a7e569be@ti.com>
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
Cc: Suman Anna <s-anna@ti.com>, Vignesh R <vigneshr@ti.com>, Jyri Sarha <jsarha@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [191213 05:28]:
> On 11/12/19 10:50 pm, Tony Lindgren wrote:
> > We can now probe devices with ti-sysc interconnect driver and dts
> > data. Let's drop the related platform data and custom ti,hwmods
> > dts property.
> > 
> > As we're just dropping data, and the early platform data init
> > is based on the custom ti,hwmods property, we want to drop both
> > the platform data and ti,hwmods property in a single patch.
> > 
> > Note that we also must tag rtc as disabled on am43x-epos-evm as
> > it's not accessible according to commit 4321dc8dff35 ("ARM: AM43XX:
> > hwmod: Add rtc hwmod").
> 
> Both AM3 & AM4 are crashing while probing rtc. Due to rtc-clkctrl enable
> failure. So this breaks AM4/3.

Oh thanks for letting me know. I'll take a look.

Regards,

Tony
