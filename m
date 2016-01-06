From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 6 Jan 2016 10:26:50 -0800
Message-ID: <20160106182650.GM12777@atomide.com>
References: <20160104170206.GC12777@atomide.com> <201601041834.56056@pali>
 <20160104174001.GD12777@atomide.com> <568AC0F9.2010304@gmail.com>
 <20160105041356.GE12777@atomide.com> <20160105084947.GG22661@pali>
 <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568D5669.4040801@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160106 10:01]:
> 
> Unfortunately, it seems there is more to be fixed. It booted several times
> to the userspace, but after a couple of shutdowns, rootfs became corrupted
> again. I flashed, installed linux 4.4, but the same happened after the first
> shutdown with 4.4:

Hmm. Care to verify that your onenand really gets detected at 83 MHz like
your earlier logs show? Below is a patch that should show it.

Also, do things now work reliably for you with CONFIG_OMAP_GPMC_DEBUG
enabled? Or does that also produce corruption after few reboots?

Regards,

Tony

8< --------------
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -153,6 +153,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 		freq = 0;
 	}
 
+	pr_info("onenand rate detected: %i\n", freq);
+
 	return freq;
 }
