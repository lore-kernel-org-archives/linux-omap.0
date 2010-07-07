From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Wed, 7 Jul 2010 15:02:42 +0300
Message-ID: <20100707120241.GN1920@atomide.com>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com>
 <201006070809.47853.luke@dashjr.org>
 <AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
 <201006071115.34881.luke@dashjr.org>
 <AANLkTinod9geJbbfdOIhB465qi6xHqfH-1vL048Bc3fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52614 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0GGMCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:02:53 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinod9geJbbfdOIhB465qi6xHqfH-1vL048Bc3fa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Luke-Jr <luke@dashjr.org>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

* Govindraj <govindraj.ti@gmail.com> [100608 09:24]:
> On Mon, Jun 7, 2010 at 9:45 PM, Luke-Jr <luke@dashjr.org> wrote:
> > On Monday 07 June 2010 08:28:51 am Govindraj wrote:
> >> Link:
> >> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summa
> >> ry
> >>
> >> Branch:
> >> pm-wip/uart
> >
> > This branch doesn't appear to have omap-serial.c at all...
> >
> >> If you are trying to use with any client device connected to uart
> >> then we need to ensure the client driver speaks to omap-serial
> >> dev entries.
> >
> 
> You need apply the driver patch on top of this branch.
> 
> [PATCH v3] serial: Add OMAP high-speed UART driver.

Do we still have a dependency to pm-wip/uart branch? Can you please
check if you can rebase all these patches on top of linux-omap for-next
branch?

Regards,

Tony
