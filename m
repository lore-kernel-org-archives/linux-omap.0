From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: u-SD card in v4.2+
Date: Wed, 13 Jan 2016 11:20:08 -0800
Message-ID: <20160113192007.GK12777@atomide.com>
References: <20160106204627.GA21477@amd>
 <568DFA4B.7030308@ti.com>
 <20160107113408.GA26618@amd>
 <201601092344.44641@pali>
 <56936A77.9070803@ti.com>
 <20160113191240.GA10717@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113191240.GA10717@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160113 11:13]:
> On Mon 2016-01-11 14:10:23, Kishon Vijay Abraham I wrote:
> > 
> > 'select' is generally not recommended since it selects a config without
> > caring for the dependency. With adding 'depends on', MMC won't be enabled and
> > will end up in the same problem.
> 
> Well... it really should "depend on". Not ideal, but you'll likely
> realize what went on.
> 
> Silently compiling known-bad kernel is ... well.. bad.

Force selects will lead into build errors sooner or later.

> > Tony has already added a Documentation noting that CONFIG_REGULATOR_PBIAS
> > should be enabled for MMCs to work.
> > commit d8e1f5ed11a39a68da00f05000466c4f6db4456e
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Mon Oct 12 16:19:54 2015 -0700
> > 
> >     Documentation: ARM: List new omap MMC requirements
> > 
> > Maybe we should also make the error message a little more verbose to tell the
> > user that CONFIG_REGULATOR_PBIAS be selected?
> 
> That would help.
> 
> As would #error if we recognize broken config.

Can't we just add a check to the omap_hsmmc.c? In cases where
MMC1 has the PBIAS regulator configured but not available, print
an error about missing CONFIG_REGULATOR_PBIAS error and return
-EPROBE_DEFER?

Regards,

Tony
