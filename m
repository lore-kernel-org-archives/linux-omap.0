From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
Date: Thu, 5 Jan 2017 09:56:20 -0800
Message-ID: <20170105175619.GA56877@google.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170105171845.GK4310@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 05, 2017 at 09:18:45AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170105 07:37]:
> > * Teresa Remmet <t.remmet@phytec.de> [170105 06:57]:
> > > To improve NAND safety we updated the partition layout.
> > > Added barebox backup partition and removed kernel and oftree
> > > partition. They are kept in ubi now.
> > 
> > What about the users with earlier partition tables?
> > 
> > Please read about "flag day" changes, typically they are not
> > acceptable.
> 
> Adding Brian and Adam to Cc. Can you guys come up with some
> solution on this?

I don't have much context for this thread, and no I don't plan to solve
your problems for you. But I can provide tips!

> I'm suggesting we leave the kernel nodes empty and let u-boot
> populate them, so maybe you guys can discuss this on the related
> lists.

That's an option. I've worked with platforms that did something like
this, and that's really one of the only ways you can handle putting
partition information in the device tree. You're really hamstringing
yourself when you put all the partition information in the device tree.
And it's just dumb once that gets codified in the kernel source tree.

The best solution would be to try to migrate away from static device
tree representations of partition info entirely. UBI volumes are best
where possible. If not, then some other kind of on-flash data structures
(along the lines of a GPT) with a corresponding MTD partition parser is
an OK alternative. Unfortunately, there isn't any good standard format
for this on MTD, so it's typically all custom -- and so people use the
easiest approach: device tree. And it's even more difficult with NAND,
which has reliability problems, especially with static data (e.g., read
disturb).

Anyway, the parser solution is helpful only if one can properly fix the
"flag day" first. And it requires a little bit more work to be generally
useful; I posted some work for this over a year ago, but bikeshedding
brought it down.

> The rest of the series looks fine to me so applying it into
> omap-for-v4.11/dt.

Brian
