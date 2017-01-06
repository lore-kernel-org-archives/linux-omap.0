From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
Date: Fri, 6 Jan 2017 10:20:53 -0800
Message-ID: <20170106182052.GA127120@google.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
 <20170105175619.GA56877@google.com>
 <1483694849.3634.6.camel@phytec.de>
 <20170106160222.GC2630@atomide.com>
 <CAHCN7xL2n0qsg61i85o7DczanMH1E=HWhNvqUtTH9UhEVBvd8g@mail.gmail.com>
 <20170106161421.GD2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170106161421.GD2630@atomide.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Teresa Remmet <t.remmet@phytec.de>, Brian Norris <computersforpeace@gmail.com>, Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 06, 2017 at 08:14:22AM -0800, Tony Lindgren wrote:
> * Adam Ford <aford173@gmail.com> [170106 08:06]:
> > On Fri, Jan 6, 2017 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Teresa Remmet <t.remmet@phytec.de> [170106 01:28]:
> > >> Am Donnerstag, den 05.01.2017, 09:56 -0800 schrieb Brian Norris:
> > >> > On Thu, Jan 05, 2017 at 09:18:45AM -0800, Tony Lindgren wrote:
> > >> > > I'm suggesting we leave the kernel nodes empty and let u-boot
> > >> > > populate them, so maybe you guys can discuss this on the related
> > >> > > lists.
> > >> > That's an option. I've worked with platforms that did something like
> > >> > this, and that's really one of the only ways you can handle putting
> > >> > partition information in the device tree. You're really hamstringing
> > >> > yourself when you put all the partition information in the device
> > >> > tree.
> > >> > And it's just dumb once that gets codified in the kernel source tree.
> > >> >
> > >>
> > >> In our case the bootloader does pass the partition table to the kernel.
> > >> So it gets overwritten anyway. This was just more for backup,
> > >> if someone uses a different bootloader. But I'm fine with removing the
> > >> nand partition table completely from the kernel device tree.
> > >> Same with the SPI nor partition table.

Ah, well if these are essentially just a backup, then why do they need
changed at all? To be more precise about my "dumb" statement: it seems
unwise to assume that all systems using a particular board will have the
same partition layout. So *relying* on the in-kernel DTS(I) files to
have a universal partition layout would likely cause problems.

I don't have much problem with keeping a sample layout there as a
backup, if you find it useful. But it seems like it will be hard to
argue that you can ever change it in the future.

Anyway, the ofpart mechanism is there, and it's fine to use it, but it's
up to you to understand the implications and manage the backwards
compatibility problems :)

> > >> I will send patches for this.
> > >
> > > OK thanks! Also thank you Brian for your comments.
> > >
> > 
> > Tony - I tested leaving the partition info as-is with the updates from
> > the bootloader and it works.  Would you prefer that I match Brian and
> > remove the partition table completely, or should I just leave my board
> > alone?
> > 
> > I am good either way.
> 
> OK. How about let's remove the partitions from kernel for v4.11 as
> clean-up then for cases where the bootloader might change them?

I don't have much stake in this but...if there were any systems using
the backup layout (i.e., the in-kernel partition layout), wouldn't that
break them? Is there a problem with just leaving them alone?

Brian
