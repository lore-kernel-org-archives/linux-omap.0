From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] watchdog: cleanup a bit omap_wdt.c
Date: Sat, 20 Sep 2008 09:13:26 +0100
Message-ID: <20080920081326.GB11114@flint.arm.linux.org.uk>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-3-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-4-git-send-email-felipe.balbi@nokia.com> <200809191741.44986.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752924AbYITIOJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200809191741.44986.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 19, 2008 at 05:41:44PM -0700, David Brownell wrote:
> On Friday 19 September 2008, Felipe Balbi wrote:
> > =A0static int omap_wdt_open(struct inode *inode, struct file *file)
> > =A0{
> > -=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev;
> > -=A0=A0=A0=A0=A0=A0=A0void __iomem *base;
> > -=A0=A0=A0=A0=A0=A0=A0wdev =3D platform_get_drvdata(omap_wdt_dev);
> > -=A0=A0=A0=A0=A0=A0=A0base =3D wdev->base;
> > +=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev =3D platform_get_dr=
vdata(omap_wdt_dev);
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *base =3D wdev->base;
> > +
>=20
> Oh, I see where "omap_wdt_dev" (global) gets used.  The normal
> way to do stuff like that is using void* pointers placed in the
> inode and file structures for exactly that purpose.

You don't have an inode or a file structure until open() is called -
at which point it _is_ placed in file->private_data.  So this driver
is doing the right thing.
