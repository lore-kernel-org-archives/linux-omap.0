From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Date: Wed, 28 Nov 2007 13:09:11 -0800
Message-ID: <20071128210911.GZ11825@atomide.com>
References: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
	<010001c82b47$71eae130$ec8818ac@ent.ti.com>
	<014f01c82cc4$82ad3260$ec8818ac@ent.ti.com>
	<20071123212831.GJ559@atomide.com>
	<008b01c830e7$a650a220$ec8818ac@ent.ti.com>
	<20071127125543.GA6534@1BRL00624.americas.nokia.com>
	<009a01c83182$9beeff20$ec8818ac@ent.ti.com>
	<20071128124115.GC6667@1BRL00624.americas.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071128124115.GC6667@1BRL00624.americas.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <ext-felipe.lima@nokia.com>
Cc: linux-omap-open-source@linux.omap.com, ext Sameer <x0081444@ti.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <ext-felipe.lima@nokia.com> [071128 08:56]:
> On Wed, Nov 28, 2007 at 11:20:38AM +0530, ext Sameer wrote:
> > Hi,
> > Please ignore the previous patch.
> > The following patch provides the onenand support for OMAP3.
> > The patch enables the onenand in def_config file, enable onenand Kconfig for OMAP3 and redeclaring the omap2_sleep_block(), omap2_allow_sleep() according to CONFIG_PM defination in pm.h according to Felipe Balbi's comments.

Pushing today.

Tony
