From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 06/39] ARM: OMAP2+: onenand: return value in init
 function
Date: Thu, 3 May 2012 08:54:08 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E982A0E@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <91c09cb6a6cb5e87acdcc3f6100a87b4c2a3dd41.1335874494.git.afzal@ti.com>
 <4FA01421.9080808@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab2ECIy3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:54:29 -0400
In-Reply-To: <4FA01421.9080808@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Sergei,

On Tue, May 01, 2012 at 22:19:37, Sergei Shtylyov wrote:
> > +
> > +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> > +		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> 
>     You can use IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2) instead these two.

Thanks for educating me.

Regards
Afzal
