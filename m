From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/5] watchdog: cleanup a bit omap_wdt.c
Date: Sat, 20 Sep 2008 08:32:14 -0700
Message-ID: <200809200832.15440.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <200809191741.44986.david-b@pacbell.net> <20080920081326.GB11114@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:24455 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750781AbYITPcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 11:32:33 -0400
In-Reply-To: <20080920081326.GB11114@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

On Saturday 20 September 2008, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2008 at 05:41:44PM -0700, David Brownell wrote:
> > On Friday 19 September 2008, Felipe Balbi wrote:
> > > =A0static int omap_wdt_open(struct inode *inode, struct file *fil=
e)
> > > =A0{
> > > -=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev;
> > > -=A0=A0=A0=A0=A0=A0=A0void __iomem *base;
> > > -=A0=A0=A0=A0=A0=A0=A0wdev =3D platform_get_drvdata(omap_wdt_dev)=
;
> > > -=A0=A0=A0=A0=A0=A0=A0base =3D wdev->base;
> > > +=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev =3D platform_get_=
drvdata(omap_wdt_dev);
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *base =3D wdev->base;
> > > +
> >=20
> > Oh, I see where "omap_wdt_dev" (global) gets used.  The normal
> > way to do stuff like that is using void* pointers placed in the
> > inode and file structures for exactly that purpose.
>=20
> You don't have an inode or a file structure until open() is called -
> at which point it _is_ placed in file->private_data.  So this driver
> is doing the right thing.

Well, the conventional thing for misc drivers, at any rate.  In
various other drivers, inode->i_private is set up earlier, just
to avoid such a need for globals (or equivalent).

One could argue that this idiom is ugly ... and fix it by having
misc_open() in drivers/char/misc.c initialize i_private before
delegating to the miscdevice->fops->open().  Even just setting
it to the miscdevice pointer would suffice with this driver;
container_of(i_private, struct omap_wdt_dev, omap_wdt_miscdev)
would then return what get_drvdata() returns, sans global.

But that wouldn't be just cleaning up this watchdog.

=3D Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
