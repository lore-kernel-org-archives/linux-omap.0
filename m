From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 04/39] ARM: OMAP2+: gpmc: Acquire NAND CS value
Date: Tue, 15 May 2012 06:37:08 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98C2CD@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
 <4FA05292.7030902@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9829B0@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98BD5A@DBDE01.ent.ti.com>
 <4FB1F808.9080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40972 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2EOGhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 02:37:19 -0400
In-Reply-To: <4FB1F808.9080500@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Thomas,

On Tue, May 15, 2012 at 12:00:32, Thomas Weber wrote:

> > I need a help.
> >
> > Can someone familiar with boards - devkit8000, omap3touchbook, overo boards,
> > let me know GPMC CS on which NAND is connected.
> On Devkit8000 the NAND is connected to CS0.

Thanks for the information

> I thought that all NAND devices for booting are connected to CS0, 
> because of ROM code?
> 
> According to spruf98w.pdf:
> 
> 25.4.7.4 NAND
> ...
>   * The device is connected to CS0.

Yes, expecting they should be, looking for confirmation.

Regards
Afzal
