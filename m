From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
Date: Mon, 6 Mar 2017 10:41:13 -0800
Message-ID: <20170306184113.GN20572@atomide.com>
References: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
 <f8862417-e9e0-e2ac-865a-9684f96a5128@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f8862417-e9e0-e2ac-865a-9684f96a5128@ti.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree Mailing List <devicetree@vger.kernel.org>, Schuyler Patton <spatton@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Franklin S Cooper Jr <fcooper@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, "Quadros,
 Roger" <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [170221 02:13]:
> On Tuesday 21 February 2017 03:30 PM, Sekhar Nori wrote:
> > From: Schuyler Patton <spatton@ti.com>
> > 
> > AM571x IDK and the AM572x IDK use CAN1 interface.
> > This patch enables it for both boards.
> > 
> > Tested on AM572x IDK using cansequence.
> > 
> > Signed-off-by: Schuyler Patton <spatton@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > [nsekhar@ti.com: move to use DRA7XX_CORE_IOPAD())
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> I should have noted that although CAN does function on the IDK with this
> patch, there are "omap_hwmod: dcan1: _wait_target_disable failed"
> messages that come up due to lack of workaround for errata i893[1]
> 
> Roger does have some patches to workaround that errata. If you want to
> wait for those patches to be submitted and accepted first, it should be
> fine as well.

OK let's wait a bit on this then to avoid introducing extra warnings.

Regards,

Tony

> [1] http://www.ti.com/lit/er/sprz436b/sprz436b.pdf
