From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v2 05/17] OMAP2,3 DSS Driver register moved to mach_omap2
Date: Wed, 22 Dec 2010 16:55:32 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F28E448@dbde02.ent.ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-6-git-send-email-svadivu@ti.com>
 <1292939360.22441.57.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47789 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab0LVLZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 06:25:42 -0500
In-Reply-To: <1292939360.22441.57.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, December 21, 2010 7:19 PM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH v2 05/17] OMAP2,3 DSS Driver register moved to
> mach_omap2
> 
> On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > Move DSS driver register from board file to devices.c
> > Changed device name from omapdss to omap_display as the
> > driver takes care of panel information.
> 
> Here you do two separate things, adding the omap_display_init() and
> changing the driver name. The latter should be in the previous patch, I
> suppose.
[Senthil]  Yes, I can change the driver name first and then omap_display_init() as 2 small patches.  When I do this I have to do similarly for board files too.  Then the board file related changes alone would be 3 separate patches - 1. driver name change, 2.  omap_display_init, 3.  Regulator initialization being done with driver name

If this is fine, then I can send v3 version of the patch set.
> 
>  Tomi
> 
