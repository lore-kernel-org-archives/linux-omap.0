From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Wed, 05 Nov 2008 12:05:56 +0200
Message-ID: <1225879556.8052.5.camel@tubuntu>
References: <20081104160946.19071.44903.stgit@tubuntu>
	 <20081104161038.19071.98198.stgit@tubuntu>
	 <D518F5F9-95AB-4881-BD63-8135263203AC@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28878 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYKEKGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 05:06:42 -0500
In-Reply-To: <D518F5F9-95AB-4881-BD63-8135263203AC@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 2008-11-04 at 18:28 +0100, ext Koen Kooi wrote:
> Op 4 nov 2008, om 17:10 heeft Tomi Valkeinen het volgende geschreven:
> 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> >
> > arch/arm/mach-omap2/board-omap3beagle.c |  121 ++++++++++++++++++++++ 
> > ++++++---
> > 1 files changed, 108 insertions(+), 13 deletions(-)
> >
> > +static struct omap_display_data beagle_display_data_dvi = {
> > +	.type = OMAP_DISPLAY_TYPE_DPI,
> > +	.name = "dvi",
> > +	.panel_name = "panel-dvi",
> > +	.u.dpi.data_lines = 24,
> > +	.panel_reset_gpio = 170,
> > +	.panel_enable = beagle_enable_dvi,
> > +	.panel_disable = beagle_disable_dvi,
> 
> gpio 170 is the enable (or disable, I forget which) for the DVI framer  
> (TFP410), not a reset gpio. It would be nice to have a way to enable/ 
> disable the framer  from userspace since it burns 60-100mA.

Well, is there a big difference between reset and enable? Anyway, you
can do

echo "dvi e:0" > /sys/devices/platform/omapfb/displays

and it will turn off the power.

Or, alternatively, use the framebuffer blanking, although that has not
been implemented to the panel-dvi.c (it's in panel-sdp3430.c). 

> regards,
> 
> Koen

 Tom

