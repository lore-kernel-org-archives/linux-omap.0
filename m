From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Thu, 8 Jul 2010 12:08:22 +0300
Message-ID: <20100708090821.GC23326@nokia.com>
References: <1277483122-3616-1-git-send-email-nm@ti.com>
 <20100707123633.GT1920@atomide.com>
 <4C34B840.3060907@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64126 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0GHJJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:09:16 -0400
Content-Disposition: inline
In-Reply-To: <4C34B840.3060907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Hi,

On Wed, Jul 07, 2010 at 07:24:16PM +0200, ext Nishanth Menon wrote:
>I am not sure.. if you would like drivers to be modprobabe, there may be
>quirks that you'd want to enable based on cpu_is_omapxxx checks. so it
>probably does not make sense to __initdata the revision/feature variables.

can't you pass the quirks via pdata, then ?

-- 
balbi

DefectiveByDesign.org
