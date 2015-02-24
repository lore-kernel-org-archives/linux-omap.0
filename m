From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Mon, 23 Feb 2015 16:11:45 -0800
Message-ID: <20150224001145.GK32521@atomide.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
 <20150223230205.GJ32521@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150223230205.GJ32521@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150223 15:10]:
> * Marc Zyngier <marc.zyngier@arm.com> [150223 09:48]:
> > This series is extracted from [4], which is trying to remove all
> > traces of gic_arch_extn from the tree. As some maintainers are more
> > responsive than others (understatement of the year...), I've decided
> > to split it per sub-arch, and get it moving, at least partially.
> > 
> > This series addresses OMAP{4,5} by converting the WUGEN to stacked
> > domains. The DRA7 crossbar gets the same treatment.
> > 
> > It is worth realizing that:
> > 
> > - I haven't been able to test this as much as I would have wanted to
> >   (it's only been tested on omap4 and omap5).
> > 
> > - This actively *breaks* existing setups. Once you boot a new kernel
> >   with an old DT, suspend/resume *will* be broken. Old kernels on a
> >   new DT won't even boot! You've been warned. This really outline the
> >   necessity of actually describing the HW in device trees...
> 
> Could we parse still the old binding and produce warning for the
> case when a new kernel is booted with the old DT? That would make
> it easier for people to debug what's going on.

Other than that, this series seems to behave for me. Please feel
free to add Acked-by: Tony Lindgren <tony@atomide.com>. It Looks
like this series should be applied into an immutable branch
against v4.0-rc1 that I can pull in as needed to avoid merge
conflicts with the dts files.

Regards,

Tony
