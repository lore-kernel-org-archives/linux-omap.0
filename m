From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Wed, 7 Jan 2015 00:27:17 +0200
Message-ID: <20150106222717.GC6071@fuloong-minipc.musicnaut.iki.fi>
References: <20150106170433.GA5408@amd>
 <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd>
 <20150106202857.GB32308@saruman>
 <20150106205000.GB13902@amd>
 <20150106205730.GA6071@fuloong-minipc.musicnaut.iki.fi>
 <20150106220805.GD13902@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150106220805.GD13902@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 06, 2015 at 11:08:05PM +0100, Pavel Machek wrote:
> On Tue 2015-01-06 22:57:30, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Tue, Jan 06, 2015 at 09:50:00PM +0100, Pavel Machek wrote:
> > > PS: Unfortunately, N900 will not boot using nfsroot in 3.16+ at least,
> > > and boot from MMC card is broken and has been for quite some time.
> > 
> > USB networking works fine with 3.19-rc3 and also MMC card rootfs.
> 
> Does nfsroot work for you? USB networking works as a module but not
> build-in. [Patch is available for this one.]
> 
> u-SD card seems to have similar problem. If I try it after boot, I can
> access it ok, but using u-SD card for rootfs fails. If it works for
> you, it would be interesting to know.

I haven't tried nfsroot, but I've been using USB networking for ssh
for a couple of years without issues. I have g_ether as module.

Also I recently switched rootfs to u-SD card, and it (MMC) works fine
as builtin.

But I'm mounting it from userspace (using builtin initramfs inside
zImage), with a poll loop that waits for a device to appear. Maybe if you
do it from kernel you need to use root wait/delay etc. options?

> I'm loading zImage using 0xffff directly from the PC.

Same here.

A.
