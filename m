From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Tue, 17 May 2011 14:44:31 +0300
Message-ID: <1305632671.1847.5.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>
	 <1305535980.2002.34.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DC6BE57@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56603 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753570Ab1EQLoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 07:44:38 -0400
Received: by mail-ew0-f49.google.com with SMTP id 3so120998ewy.36
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 04:44:36 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DC6BE57@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Mon, 2011-05-16 at 16:56 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: Valkeinen, Tomi
> > Sent: Monday, May 16, 2011 2:23 PM
> > To: Igor Grinberg
> > Cc: Janorkar, Mayuresh; tony@atomide.com; linux-omap@vger.kernel.org;
> > Stanley Miao
> > Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2

> > +static struct omap_dss_device ldp_lcd_device = {
> > +	.name			= "lcd",
> > +	.driver_name		= "generic_dpi_panel",
> > +	.type			= OMAP_DISPLAY_TYPE_DPI,
> > +	.phy.dpi.data_lines	= 16,
> 
> From a working DSS code at:
> http://lxr.linux.no/#linux+v2.6.38/drivers/video/omap/lcd_ldp.c
> .data_lines should be 18

Right, I missed that. Thanks.

 Tomi


