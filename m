From: Tony Lindgren <tony@atomide.com>
Subject: Re: Extcon build failure in next
Date: Wed, 29 Jun 2016 22:41:13 -0700
Message-ID: <20160630054112.GN28140@atomide.com>
References: <20160630053705.GM28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160630053705.GM28140@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160629 22:41]:
> Hi Chanwoo,
> 
> Looks like current Linux next fails to build with at least
> omap2plus_defconfig because of:
> 
> ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1163: recipe for target 'modules' failed
> make: *** [modules] Error 2
> Kernel build failed
> 
> Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?

Also I'm seeing:

drivers/extcon/extcon.c: In function 'extcon_register_notifier':
drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (idx >= 0) {
         ^

Regards,

Tony
