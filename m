From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v2 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
Date: Mon, 13 Dec 2010 17:01:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F28E417@dbde02.ent.ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
 <1291031503-21036-2-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45094 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162Ab0LMLbw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 06:31:52 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin, Tony,

Gentle reminder.
Is there anything else pending on me to get these first 4 patches pulled in l-o?

Regards,
Senthil

> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Monday, December 06, 2010 1:14 PM
> To: 'tony@atomide.com'; Cousson, Benoit
> Cc: Guruswamy, Senthilvadivu; khilman@deeprootsystems.com;
> tomi.valkeinen@nokia.com; paul@pwsan.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Subject: RE: [PATCH v2 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI
> VENC
> 
> Tony,
> 
> > -----Original Message-----
> > From: Guruswamy, Senthilvadivu
> > Sent: Monday, November 29, 2010 5:21 PM
> > To: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com;
> paul@pwsan.com;
> > Hiremath, Vaibhav; linux-omap@vger.kernel.org
> > Cc: Guruswamy, Senthilvadivu
> > Subject: [PATCH v2 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
> >
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > Database generated for OMAP2420 Display Sub System.
> > Since dss is also considered as an IP as dispc,rfbi,
> > name it as dss_dss.
> >
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > Acked-by: Benoit Cousson <b-cousson@ti.com>
> > ---
> The first 4 patches are reviewed by Acked by Benoit.
> These patches are also tested on 2420-N800, 2430SDP, 3430SDP as mentioned
> in cover letter.
> 
> Could you please let me know what is needed further to push this changes
> to l-o.
> 
> Regards,
> Senthil
> 
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  283
> > ++++++++++++++++++++++++++++

