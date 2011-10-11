From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: omap2+: stub out omap*_volt_data
Date: Tue, 11 Oct 2011 15:57:41 +0200
Message-ID: <201110111557.41396.arnd@arndb.de>
References: <1397689.kebELtC4N3@wuerfel> <87ipnwhepq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ipnwhepq.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Monday 10 October 2011, Kevin Hilman wrote:
> > I got this build error only now after pulling in the latest omap series, but
> > I cannot tell what caused it. It's also not clear to me if this is the correct
> > solution. Please ack or provide a better fix.
> 
> This code was merged for v2.6.39, so not sure why this error is only
> showing up for you now.  I just tried a !CONFIG_PM_OPP build on v2.6.39
> and get the same errors, so it's been lingering.
> 
> Maybe you haven't had a randconfig that disabled CONFIG_PM_OPP before?

I don't know. The best explanation is that this is a very unlikely case.
I've done many thousand randconfig builds now and have not seen it before.

Of course, since the output of randconfig is random, it could indeed just
be a coincidence.

> Anyways, the fix is fine with me.

Thanks,

	Arnd
