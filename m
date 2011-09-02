From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/4] OMAP4: TWL: Add common omapdss supplies
Date: Fri, 02 Sep 2011 10:30:50 +0300
Message-ID: <1314948650.3374.25.camel@deskari>
References: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
	 <1314001599-17951-3-git-send-email-tomi.valkeinen@ti.com>
	 <4E607A40.8000707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40129 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755809Ab1IBHqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 03:46:31 -0400
In-Reply-To: <4E607A40.8000707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2011-09-02 at 12:10 +0530, Archit Taneja wrote:
> Hi,
> 
> On Monday 22 August 2011 01:56 PM, Valkeinen, Tomi wrote:
> > OMAP DSS normally gets power from VCXIO on OMAP4. Add configuration
> for
> > this into twl-common.c
> >
> > Mark VCXIO as always_on, as VCXIO is used by multiple components,
> > including the MPU, and turning it off when DSS doesn't need it would
> > lead the device to halt.
> 
> I had a query. Is this the right place to set always_on to true?
> Won't 
> this lead to VCXIO being always on all omap4 boards? Is it necessary 
> that VCXIO will be used to power on MPU for all omap4 boards? 

I don't really know, but TRM's 27.2.1 Power Requirements chapter shows
vcxio connected to multiple places. It's an example, but I would guess
it is the common setup, thus setting it to always on in twl-common.c
sounds ok.

If there will be an omap4 board with different setup, then we need to
revisit this.

 Tomi


