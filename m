From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 01/15] OMAP: DSS2: DSI: fix VC channels in send_short
 and send_null
Date: Fri, 08 Jan 2010 15:33:24 +0200
Message-ID: <1262957604.2127.94.camel@tubuntu.research.nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
	 <A24693684029E5489D1D202277BE894451312028@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48863 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab0AHNck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:32:40 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894451312028@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2010-01-08 at 14:29 +0100, ext Aguirre, Sergio wrote:
> Tomi,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> > Sent: Friday, January 08, 2010 7:23 AM
> > To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> > Cc: Tomi Valkeinen
> > Subject: [PATCH 01/15] OMAP: DSS2: DSI: fix VC channels in send_short and
> > send_null
> > 
> > - dsi_vc_send_short() needs to use dest_per for the peripheral id
> > - dsi_vc_send_null() was always using channel id 0
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> >  drivers/video/omap2/dss/dsi.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> > index 5936487..c37bc5b 100644
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -1999,7 +1999,8 @@ static int dsi_vc_send_short(int channel, u8
> > data_type, u16 data, u8 ecc)
> >  		return -EINVAL;
> >  	}
> > 
> > -	data_id = data_type | channel << 6;
> > +	/* data_id = data_type | channel << 6; */
> 
> Why do you need this old line commented?

Ah. I don't =). Thanks.

 Tomi


