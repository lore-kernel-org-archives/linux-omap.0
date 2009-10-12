From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 5/8] board-rx51-peripherals: split vaux3
 and vmmc2 supplies
Date: Mon, 12 Oct 2009 11:08:58 +0300
Message-ID: <20091012080858.GB13234@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
	<20091008132109.GD29176@rakim.wolfsonmicro.main>
	<20091009064529.GD6616@esdhcp037198.research.nokia.com>
	<20091009110346.GC5082@sirena.org.uk>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091009110346.GC5082@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Fri, Oct 09, 2009 at 01:03:47PM +0200, Mark Brown wrote:
> On Fri, Oct 09, 2009 at 09:45:29AM +0300, Eduardo Valentin wrote:
> > On Thu, Oct 08, 2009 at 03:21:10PM +0200, Mark Brown wrote:
> > > On Thu, Oct 08, 2009 at 02:58:54PM +0300, Eduardo Valentin wrote:
> 
> > > I may have missed it but I don't see rx51_vmmc2_supply added back
> > > anywhere in the patch?
> 
> > yes. That's because this patch is just to split then. As you can see
> > in current code, this structure, rx51_vmmc2_supply, is actually used
> > by rx51_vaux3_mmc and rx51_vmmc2. So the idea is to have separated
> > supplies for each one. This patch just splits then. Patch 0006 of this
> > series adds usage of rx51_vmmc2_supply.
> 
> Might be an idea to change the description to something like "add a
> separate structure for...", it wasn't 100% clear what was going on
> (probably because the diff doesn't include sufficient context to make it
> clear).
> 
> > > ...using dev_name rather than dev should avoid the need to do this at
> > > runtime.

I'm afraid using dev_name is not that easy. The mmc driver generates device
name at runtime. That's why this board file setups .dev at runtime as well.

rx51_twlgpio_setup -> twl4030_mmc_init -> omap2_init_mmc


So, changing this supply to something static using .dev_name it is not
possible with current code. That would need refactoring the whole mmc and
hsmmc setup. And the device naming procedure is dependent on cpu as well.
Check arch/arm/mach-omap2/device.c:omap2_init_mmc.



> 
> > I see your point. As mentioned above, this patch is just a split.
> > I just added rx51_vaux3_supply to be owned by rx51_vaux3_mmc. And
> > let the code behavior as it was before.
> 
> > Maybe your proposal must be sent into a separated patch/patch series (?).
> 
> Yes, it's definately a separate patch - might be good to put it into the
> series before this one.



-- 
Eduardo Valentin
