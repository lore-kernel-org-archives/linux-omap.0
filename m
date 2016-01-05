From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Mon, 4 Jan 2016 20:13:56 -0800
Message-ID: <20160105041356.GE12777@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568AC0F9.2010304@gmail.com>
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

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160104 10:59]:
> Hi,
> 
> On  4.01.2016 19:40, Tony Lindgren wrote:
> >>On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> >>>> >Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
> >>>> >dmesg output?
> 
> Here it is, including the pre-gpmc log, keep in mind this is with restored
> HWMOD_INIT_NO_RESET flag so rootfs is functional and I can get dmesg output
> from the syslog. Don't know if it is helpful :). Also, this device has
> Numonyx onenand (HW rev. 2204), unlike most of the others which have Samsung
> onenand (HW rev. 2101 etc), no idea if it is relevant.

Thanks. I got the problem reproduced here too.

[    1.915557] gpmc cs0 after gpmc_cs_set_timings:
[    1.920410] cs0 GPMC_CS_CONFIG1: 0xfb001201

Looks like in the failing case the clock rates are not properly
calculated in GPMC and GPMCFCLKDIVIDER is set wrong in
GPMC_CS_CONFIG1. Need to look at it more to figure out what's the
best way to fix this.

Regards,

Tony
