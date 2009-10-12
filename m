From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] board-rx51-peripherals: split vaux3
 and vmmc2 supplies
Date: Mon, 12 Oct 2009 10:18:20 +0100
Message-ID: <20091012091820.GC3308@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
	<20091008132109.GD29176@rakim.wolfsonmicro.main>
	<20091009064529.GD6616@esdhcp037198.research.nokia.com>
	<20091009110346.GC5082@sirena.org.uk>
	<20091012080858.GB13234@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091012080858.GB13234@esdhcp037198.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 12, 2009 at 11:08:58AM +0300, Eduardo Valentin wrote:

> I'm afraid using dev_name is not that easy. The mmc driver generates device
> name at runtime. That's why this board file setups .dev at runtime as well.

> rx51_twlgpio_setup -> twl4030_mmc_init -> omap2_init_mmc

> So, changing this supply to something static using .dev_name it is not
> possible with current code. That would need refactoring the whole mmc and
> hsmmc setup. And the device naming procedure is dependent on cpu as well.
> Check arch/arm/mach-omap2/device.c:omap2_init_mmc.

Oh, dear - that sounds broken for hardware that's fixed on the board.
That said, the code there looks like it's supposed to come out with the
same answer each time it's run?  How does this work with the clock API?
