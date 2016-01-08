From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Thu, 7 Jan 2016 18:26:20 -0800
Message-ID: <20160108022619.GS12777@atomide.com>
References: <20160105041356.GE12777@atomide.com> <20160105084947.GG22661@pali>
 <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568EDC8D.7070205@gmail.com>
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

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160107 13:46]:
> On  7.01.2016 20:07, Tony Lindgren wrote:
> 
> >>>Also, do things now work reliably for you with CONFIG_OMAP_GPMC_DEBUG
> >>>enabled? Or does that also produce corruption after few reboots?
> 
> I'll make further experiments as I am a bit lost what and when happens. What
> is for sure is that corruptions occurs immediately after boot without your
> patch and with CONFIG_OMAP_GPMC_DEBUG disabled. So maybe there is another
> problem in ubfs or mtd driver.

Yes it seems there's some other issue too. Maybe you can run git bisect
again and carry the fix along as an extra patch?

> Already did, every reflash and install of upstream kernel compatible SW
> takes me about 3 hours I'd rather spend on something else :). Though it
> seems that reboot issue happens no matter if CONFIG_OMAP_GPMC_DEBUG is
> enabled or not.

OK then it really seems like we do have another bug lurking around.
Maybe you can figure out an easier way to reproduce it?

> The problem is that between NOLO and kernel there is u-boot. And even if I
> am almost sure it doesn't touch onenand configs, I can't be absolutely sure.
> So those timings are not 100% reliable IMO, though close to that.

Hmm yes I'm only booting with u-boot here as my device sits in my rack.

> I'll play a bit more with printing the values with both
> CONFIG_OMAP_GPMC_DEBUG enabled and disabled and whatever I can think of,
> including dumping cs0 config from u-boot, nokia kernel and/or REing NOLO
> onenand init (already did that for N9 DDR timings, shouldn't be that hard
> for N900 GPMC). Will keep you informed on the progress. In the meanwhile I
> think your patch should make it as without it onenand is unusable.

OK will push it out then.

Regards,

Tony
