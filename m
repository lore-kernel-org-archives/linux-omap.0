From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 16:32:31 +0300
Message-ID: <200810021632.31667.peter.ujfalusi@nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <200810021601.18006.peter.ujfalusi@nokia.com> <20081002130641.GG9133@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25460 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYJBNd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 09:33:58 -0400
In-Reply-To: <20081002130641.GG9133@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thursday 02 October 2008 16:06:41 Felipe Balbi wrote:
> On Thu, Oct 02, 2008 at 04:01:17PM +0300, ext Peter Ujfalusi wrote:
> >=20
> > Hello,
> >=20
> > the diff between l-o and mainline are these commits regarding to om=
ap-keypad.c:
> >=20
> > commit fdee8764947cde1e6933e7d981ce5b9de00e83e6
> > Author: Tony Lindgren <tony@atomide.com>
> > Merge current mainline tree into linux-omap tree
> >=20
> > commit ed39c59ff267249e7e789ea3bb64afc1e9afb5bd
> > Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> > omap: fix a load of "warning: symbol 'xxx' was not declared. Should=
 it be static?"
> >=20
> > commit e85a9daa48453a4e7ffedf174b4358cdb444fbbb
> > Author: David Brownell <dbrownell@users.sourceforge.net>
> > some drivers switch away from OMAP-specific GPIO calls
> >=20
> > Should I take the relevant parts from these commits and send it to =
linux-input?
> >=20
> > Also there are other things broken in the omap-keypad driver.
> > One thing came to my mind is in the omap_kp_enable_store:=20
> > No matter what platform the code is running it tries to
> > enable/disable IRQ number 33 (IH2_BASE + 1), which is not a nice th=
ing
> > to do...
>=20
> you can pass the irq number via a struct resource and use
> platform_get_irq() on driver probe and exit calls to handle the
> request_irq() and free_irq();
>=20
> Then you're sure the irq is correct as long as the struct resource as
> well initialized.

Yes, I know that, I just mentioned that other things are still broken i=
n the omap-keypad driver.
In the OMAP1 board files the resource is filled in, but in the driver y=
ou can see this:

static ssize_t omap_kp_enable_store(struct device *dev, struct device_a=
ttribute *attr,
				    const char *buf, size_t count)
=2E
=2E
	if (state !=3D kp_enable) {
		if (state)
			enable_irq(INT_KEYBOARD);
		else
			disable_irq(INT_KEYBOARD);
		kp_enable =3D state;
	}
=2E
=2E

So, pretty much not a sane thing to do...
It is easy to fix, but that was not my point.
I'll make a patch to fix this one.

P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
