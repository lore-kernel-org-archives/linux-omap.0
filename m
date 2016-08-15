From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x: Update elm phandle binding
Date: Mon, 15 Aug 2016 09:02:20 -0700
Message-ID: <20160815160220.GP28140@atomide.com>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
 <20160713171407.GB136972@google.com>
 <9354c50f-f851-f473-a8af-0a84c951453e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9354c50f-f851-f473-a8af-0a84c951453e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <computersforpeace@gmail.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [160801 02:25]:
> On 13/07/16 20:14, Brian Norris wrote:
> > On Tue, Jul 05, 2016 at 11:32:29AM +0200, Teresa Remmet wrote:
> >> The check for the "elm_id" binding had been removed.
> >> This causes nand boot to fail on boards still using
> >> the old binding. Update the bindings on those boards.
> > 
> > Acked-by: Brian Norris <computersforpeace@gmail.com>
> > 
> > We're fixing the backward compatibility issue anyway, but might as well
> > "upgrade" the device tree.
> > 
> >> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>
> 
> Tony,
> 
> Please take this one via your OMAP DT tree. Thanks.

Applying to omap-for-v4.8/fixes finally thanks. Sorry for
the delay.

Regards,

Tony
