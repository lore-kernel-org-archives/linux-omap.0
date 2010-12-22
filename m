From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v2 04/17] OMAP2420,OMAP2430,OMAP3xx: change dss driver
 name in clock files
Date: Wed, 22 Dec 2010 15:59:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F28E447@dbde02.ent.ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-5-git-send-email-svadivu@ti.com>
 <1292939048.22441.55.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38488 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab0LVK36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 05:29:58 -0500
In-Reply-To: <1292939048.22441.55.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, December 21, 2010 7:14 PM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH v2 04/17] OMAP2420,OMAP2430,OMAP3xx: change dss driver
> name in clock files
> 
> Hi,
> 
> On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > dss driver renamed to "omap_" is done to align all the omap device names
> > with the same convention.
> 
> Does the driver work if you change the driver name from the clock files,
> but not from the driver itself? Remember that things have to work after
> each patch.
[Senthil]  Yes, it was surprising for me to that it worked.  When I dig into the code, I found that it matches for dev->id and not dev->name.
Yes, I have tested for bootup after each patch.  No crashes observed.  Errors like clk_get failed, can't get regulator would be given on some of the patches.
> 
>  Tomi

