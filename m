From: David Brownell <david-b@pacbell.net>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Sun, 23 May 2010 09:21:23 -0700 (PDT)
Message-ID: <937688.59887.qm@web180315.mail.gq1.yahoo.com>
References: <19F8576C6E063C45BE387C64729E7394044E535F3E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n2-vm0.bullet.mail.gq1.yahoo.com ([67.195.23.154]:31975 "HELO
	n2-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753338Ab0EWQVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 May 2010 12:21:24 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E535F3E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Ajay KumarGupta <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Maulik OjasMankad <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>



--- On Fri, 5/21/10, Gupta, Ajay Kumar <ajay.gupta@ti.com> wrote:

> > >Then I think these #ifdefferys are required in all
> the board files.

As I already explained:  *NO*.

Unless the board has been designed in a flakey
manner (like the DM6446 EVM) it should
have no #ifdeffery in the MUSB configuration.


> > >Then if I choose to compile the Kernel only for
> peripheral mode
> > >(Case-B above) then I would get below error from
> musb_core.c.
> > >
> > >"incompatible Kconfig role setting"

That's a *correct* report that your config is broken.
The hardware has an OTG connector, so the kernel should
be supporting OTG mode.  If it's not, that's an error;
don't try to hide such errors.

- Dave
 

