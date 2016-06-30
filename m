From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Extcon build failure in next
Date: Thu, 30 Jun 2016 13:37:30 +0200
Message-ID: <3746939.q8kt0ym6m3@wuerfel>
References: <20160630053705.GM28140@atomide.com>
 <20160630054112.GN28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160630054112.GN28140@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 29, 2016 10:41:13 PM CEST Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160629 22:41]:
> > Hi Chanwoo,
> > 
> > Looks like current Linux next fails to build with at least
> > omap2plus_defconfig because of:
> > 
> > ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
> > scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > make[1]: *** [__modpost] Error 1
> > Makefile:1163: recipe for target 'modules' failed
> > make: *** [modules] Error 2
> > Kernel build failed
> > 
> > Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?

I've sent "extcon: link devres into core module" for this

> Also I'm seeing:
> 
> drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (idx >= 0) {
>          ^

I don't see this one. Which compiler version do you use?

	Arnd
