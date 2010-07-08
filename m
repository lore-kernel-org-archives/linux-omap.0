From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Thu, 8 Jul 2010 15:34:22 +0300
Message-ID: <20100708123422.GI29007@nokia.com>
References: <1278590256.3787.14.camel@Nokia-N900>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50167 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0GHMfN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 08:35:13 -0400
Content-Disposition: inline
In-Reply-To: <1278590256.3787.14.camel@Nokia-N900>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Menon, Nishanth" <nm@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

On Thu, Jul 08, 2010 at 01:57:36PM +0200, ext Menon, Nishanth wrote:
>If pdata is passed based on board: Imagine 3630 and uart quirk. Why 
>share errata xyz over pdata for every board using 3630? Quirks are cpu 
>specific and not really domain of board..

look at usb-musb.c, it groups the generic part and only asks boards to 
pass the board-specific bits (usb mode and power).

-- 
balbi

DefectiveByDesign.org
