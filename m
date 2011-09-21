From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Wed, 21 Sep 2011 11:28:31 +0200
Message-ID: <2241590.uiCS2D9jjt@wuerfel>
References: <20110917014623.GC2937@atomide.com>
	<201109202334.43213.arnd@arndb.de>
	<201109202346.11393.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201109202346.11393.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 September 2011 23:46:11 Arnd Bergmann wrote:

> It seems that you replace the #ifdef in the board-flash.c file
> with a similar #ifdef in the header that replaces this with an
> empty inline function when the object is not built.

Found another similar problem over night, presumably in the voltage series:

arch/arm/mach-omap2/built-in.o: In function `pwrdm_register_pwrdms':
twl-common.c:(.text+0x5e20): undefined reference to `voltdm_lookup'
twl-common.c:(.text+0x5e40): undefined reference to `voltdm_add_pwrdm'
arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_infrastructure':
twl-common.c:(.init.text+0x3a4): undefined reference to `omap2xxx_voltagedomains_init'
twl-common.c:(.init.text+0x3c8): undefined reference to `omap3xxx_voltagedomains_init'
arch/arm/mach-omap2/built-in.o: In function `omap2_set_init_voltage':
twl-common.c:(.init.text+0x13c8): undefined reference to `voltdm_lookup'
arch/arm/mach-omap2/built-in.o: In function `omap3_twl_init':
twl-common.c:(.init.text+0x1f44): undefined reference to `voltdm_lookup'
twl-common.c:(.init.text+0x1f4c): undefined reference to `voltdm_lookup'

	Arnd
