From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP: DMA: Add API for setting channel dest addr
Date: Tue, 2 Mar 2010 16:03:45 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026ED961ED@dbde02.ent.ti.com>
References: <1267524941-15526-1-git-send-email-manjugk@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C44C20EC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58765 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab0CBKdv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:33:51 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C44C20EC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "S, Venkatraman" <svenkatr@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>


Santosh,

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Tuesday, March 02, 2010 3:35 PM
> To: G, Manjunath Kondaiah; linux-omap@vger.kernel.org
> Cc: Tony Lindgren; S, Venkatraman; Raja, Govindraj
> Subject: RE: [PATCH] OMAP: DMA: Add API for setting channel dest addr
> 
> Manju,
> Is this patch can build?
> 

It looks like after generating patch, I did minor changes related to 
Description directly in the patch. While doing so, I goofed up lcd->lch. 

Thanks for figuring it out. 

-Manjunath

