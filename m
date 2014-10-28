From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Tue, 28 Oct 2014 15:26:41 -0700
Message-ID: <20141028222641.GW2542@atomide.com>
References: <20141019090107.GA19132@amd>
 <201410262222.39892@pali>
 <20141026215548.GA9004@amd>
 <201410262323.17891@pali>
 <20141027195209.GP2560@atomide.com>
 <20141027223114.GU2560@atomide.com>
 <20141028220450.GA27667@amd>
 <20141028222123.GA17518@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141028222123.GA17518@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > Hi!
> > 
> > > Here's a patch that should fix the issues for built-in USB
> > > gadgets.
> > > 
> > > Pavel, care to see if this gets NFSroot over USB working again
> > > for you?
> > 
> > It seems to have did the trick for me. (Plus I needed to add
> > 
> > +CONFIG_ARM_ATAG_DTB_COMPAT=y
> > +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> > +# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> > 
> > to be able to control the command line, that's why testing took me a
> > while.)
> > 
> > Networking now works against 3.17-based kernel. Thanks!
> 
> It works on 3.18-rc1 kernel, too. (I had to hand-modify patch to apply
> to 3.17, no changes needed for 3.18-rc1.)
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Whatever we decice to do to fix this regression, it should probably
be backported to at least v3.16 stable for distro use, maybe earlier
too. I'd assume this is broken on multiple platforms currently.

Regards,

Tony
