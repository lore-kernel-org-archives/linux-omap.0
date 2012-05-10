From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Thu, 10 May 2012 05:10:22 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98A285@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA4035E.6020308@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987147@DBDE01.ent.ti.com>
 <4FA7F232.7050802@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9878EC@DBDE01.ent.ti.com>
 <4FA936E8.1080801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2EJFM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 01:12:28 -0400
In-Reply-To: <4FA936E8.1080801@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Hire

Hi Jon,

On Tue, May 08, 2012 at 20:38:24, Hunter, Jon wrote:

> > Different ways of doing things, this looks cleaner to me as already it is
> > checked, and time of execution in both cases would not differ much.
> 
> Sure. However, I think that this could be simplified so that it is
> easier to read. At a minimum you may wish to add some comments to
> explain the purposes of the multi-level if-statements as it is not
> intuitive for the reader.

Ok

> >> What happens if a device uses more than one wait-pin? In other words a
> >> device with two chip-selects that uses two wait-pins?
> > 
> > Please re-read http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67702.html
> > and your reply
> 
> Ok thats fine. Sorry for my repeated questions, but I think that this
> just highlights that this code is not clear in it purpose. So again may
> be some comments would make this all clearer.

Ok

Regards
Afzal
