From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 8 May 2012 06:27:18 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98792A@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA022FC.5040703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E982967@DBDE01.ent.ti.com>
 <4FA401C0.7070503@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98712C@DBDE01.ent.ti.com>
 <4FA7F706.1020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49696 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab2EHG1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 02:27:35 -0400
In-Reply-To: <4FA7F706.1020706@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Hire

Hi Jon,

On Mon, May 07, 2012 at 21:53:34, Hunter, Jon wrote:

> >>>> Write protect is a pin and there is only one. Like the waitpins and CS
> >>>> signals this needs to be associated with a device. It would make sense
> >>>> that this is associated with the cs data.
> >>>
> >>> As far as platform are concerned, it is associated with cs, it is only
> >>> that while configuring CS, it is propagated such that it is done once.
> >>
> >> Hmmm ... but here it looks like if write-protect is used you are going
> >> to turn it on. A feature like this seems that it does need to be handled
> >> by the device's driver. Enabling and disabling write-protect are
> >> functions that I would expect are exported to the device's driver and
> >> not directly enabled in the gpmc driver during probe. However, maybe is
> >> could be valid for the write protect to be enabled by default which
> >> could make sense. However, I don't see anywhere else in the driver to
> >> control it.
> >>
> >> Shouldn't we warn on multiple devices trying to use write-protect when
> >> parsing their configuration?
> > 
> > Even if a single device sets write protect, kernel will log it.
> 
> That does not seem sufficient. It should be flagged as an error.
> 
> Write protect is a resource like the CS and waitpins and so I would have
> thought that it should be reserved in the same way.

Isn't it valid for multiple devices to make use of write protect pin ?

Regards
Afzal
