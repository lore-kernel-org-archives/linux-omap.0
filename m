From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Thu, 21 Apr 2011 16:38:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839E6@dbde02.ent.ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-5-git-send-email-mayur@ti.com>
 <1303213323.32281.35.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1DULJR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 07:09:17 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3LB9DMj026357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:09:16 -0500
In-Reply-To: <1303213323.32281.35.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, April 19, 2011 5:12 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH 4/7] OMAP: DSS: Add i2c client driver for picodlp
> 
> On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> > The configurations and data transfer with picodlp panel happens through
> i2c.
> > An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> >
> > Signed-off-by: Mythri P K <mythripk@ti.com>
> > Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> > Signed-off-by: Mythri P K <mythripk@ti.com>
> > ---
> >  drivers/video/omap2/displays/panel-picodlp.c |  130
> +++++++++++++++++++++++++-
> >  1 files changed, 126 insertions(+), 4 deletions(-)
> 
> <snip>
> 
> > @@ -65,8 +131,10 @@ static int picodlp_panel_power_on(struct
> omap_dss_device *dssdev)
> >  	msleep(675);
> >  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> >
> > -	return 0;
> > +	picodlp_i2c_data =
> > +		i2c_get_clientdata(picod->picodlp_i2c_client);
> 
> This variable is not used at all.


Not in this patch but it is used in next patch.
I would add it as a part of next patch where it is used.

> 
>  Tomi
> 

