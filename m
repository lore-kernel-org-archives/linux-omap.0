From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Thu, 9 Nov 2017 20:10:28 +0100
Message-ID: <20171109191028.6r5bmg65gcz7ovv2@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091253.lvrzi5kbaykkxlcb@lenoch>
 <20171109175626.GD28152@atomide.com>
 <20171109181004.g55vx4iveo5sulpt@lenoch>
 <20171109182645.GE28152@atomide.com>
 <20171109183408.xbc4bacawv7li54l@lenoch>
 <20171109184828.GF28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109184828.GF28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 10:48:28AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171109 18:35]:
> > On Thu, Nov 09, 2017 at 10:26:45AM -0800, Tony Lindgren wrote:
> > > Well we should have the dependencies merged first to avoid breaking
> > 
> > Yes, that's what cover letter says :-)
> > Also, I still count on your suggestion to merge it via mtd tree.
> 
> Well only after it has been tested :) At this point I'd say
> we're best off waiting for v4.16 merge window on the clean
> up too as the merge window is about to open.
> 
> > > git bisect. After applying this and the first patch I see:
> > > 
> > > omap-gpmc 6e000000.gpmc: /ocp@68000000/gpmc@6e000000/onenand@0,0 has no 'bank-width' property
> > > omap-gpmc 6e000000.gpmc: failed to probe DT child 'onenand': -22
> > > 
> > > So seems like more dts changes are needed to test this.
> > 
> > Argh... You are right, I should add this into serie:
> > https://patchwork.kernel.org/patch/10043259/
> 
> Well don't we still need the related dts changes posted
> and merged first?

Well, except Roger's feedback, there were complete silence so far.
Note that simple fix was posted in February, this was rejected as
we should aim towards clean DT only driver. And here we are with
some doubts.

As I have no hardware nor any special knowledge going prior
initial driver commit it is rather hard to send "related dts changes"
given simple fact, that I'm unsure whenever we need to distinguish
between OMAP2 and OMAP3. Based on that we need either one or
two compatible strings.

Having two is safe, but u-boot will be unable to bring onenand equipped
igep up.

	ladis

> Regards,
> 
> Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
