From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: insecure W+X mapping at 0xd0050000
Date: Thu, 8 Mar 2018 08:24:46 -0800
Message-ID: <20180308162446.GK5799@atomide.com>
References: <20180308142818.GA9439@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308142818.GA9439@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> Insecure W+X mappings, who cares about those? I have 7 pages...

Is this with CONFIG_DEBUG_WX=y?

My guess is that it's for mapping the PM assembly to SRAM. This
is already fixed for am335x that is using drivers/misc/sram*.c.
I think omap2 - omap4 still need fixing if this is the culprit.

Regards,

Tony
