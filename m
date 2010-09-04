From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/4] omap4: Control module series
Date: Sat, 4 Sep 2010 14:33:31 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7788@dbde02.ent.ti.com>
References: <1281967423-9346-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab0IDJDi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 05:03:38 -0400
In-Reply-To: <1281967423-9346-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

Tony,
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Monday, August 16, 2010 7:34 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit;
> Shilimkar, Santosh
> Subject: [PATCH 0/4] omap4: Control module series
> 
> On omap4 control mudule is divided in four IP blocks.
> 	CTRL_MODULE_CORE	0x4a002000
> 	PAD_CTRL_MODULE_CORE	0x4a100000
> 	CTRL_MODULE_WKUP	0x4a30c000
> 	PAD_CTRL_MODULE_WKUP	0x4a31e000
> Addressing all the modules with single base address is not possible
> considering 16 bit offsets. The mux code manages the pad core and pad
> wakeup related base address inside the mux framework. For other usage
> only control core and control pad bases are necessary.
> 
> After some offline discussion with Tony, Paul and Benoit, following
> approach
> is decided to address this issue.
>  - Most usable registers are form CTRL_MODULE_CORE and
> PAD_CTRL_MODULE_CORE
>  - Control core is mapped with existing APIs and to address the pad
> control
>    module registers, a new accessor APIs is exported for OMAP4 only.
>  - Mux code maps the needed bases internally so they need not be exported.
> 
> Thanks to,
> 	- Tony and Paul for there suggestion to manage this problem.
> 	- And ofcourse Benoit to work with me on this series
> 
> The series is generated against 2.6.36-rc1 + Tony's fixes below series
> 	-	[PATCH 0/6] omap fixes for upcoming 2.6.36-rc1
> 		http://www.spinics.net/lists/linux-omap/msg34830.html
> 
> It's tested on tested on OMAP4 and OMAP3 SDPs.
> 
> Santosh Shilimkar (4):
>   omap4: control: Add ctrl_pad_base to omap_globals
>   omap4: control: Add accessor api's for pad control module
>   omap4: control: Add the register definition headers
>   omap4: control: Fix the control module register accesses
> 
Can you please see if this is good for merge in LO master?
