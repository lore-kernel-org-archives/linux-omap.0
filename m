From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Wed, 18 Aug 2010 18:22:42 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE1F2FC0@dbde02.ent.ti.com>
References: <1280987665-25639-1-git-send-email-mythripk@ti.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
	 <1282042850.2348.42.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE1F2E1B@dbde02.ent.ti.com>
 <1282122106.2348.110.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0HRMwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 08:52:51 -0400
In-Reply-To: <1282122106.2348.110.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,
	Sorry I configured my email client :).
	Here is the link for OMAP4 TRM : 
http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, August 18, 2010 2:32 PM
> To: K, Mythri P
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> 
> Hi,
> 
> On Wed, 2010-08-18 at 09:56 +0200, ext K, Mythri P wrote:
> > Hi Tomi,
> >
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Tuesday, August 17, 2010 4:31 PM
> > To: K, Mythri P
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> >
> > Hi,
> >
> > On Wed, 2010-08-11 at 11:22 +0200, ext K, Mythri P wrote:
> > > Hi Tomi,
> > > Can you please comment on the below patch . This is to add new color modes supported by OMAP4.
> > >
> > > Thanks and regards,
> > > Mythri.
> > > -----Original Message-----
> > > From: K, Mythri P
> > > Sent: Thursday, August 05, 2010 11:24 AM
> > > To: linux-omap@vger.kernel.org
> > > Cc: tomi.valkeinen@nokia.com; Semwal, Sumit; K, Mythri P
> > > Subject: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> > >
> > > From: Sumit semwal <sumit.semwal@ti.com>
> > >
> > > This patch adds support for new color modes that are supported by the video/graphics pipeline of
> OMAP4
> > >
> > > Signed-off-by: Mythri P K <mythripk@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/plat/display.h |   16 ++++++++-
> > >  drivers/video/omap2/dss/dispc.c           |   53 ++++++++++++++++++++++-------
> > >  drivers/video/omap2/dss/overlay.c         |    6 ++-
> > >  3 files changed, 59 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-
> omap/include/plat/display.h
> > > index 7a6eedd..ebf1020 100644
> > > --- a/arch/arm/plat-omap/include/plat/display.h
> > > +++ b/arch/arm/plat-omap/include/plat/display.h
> > > @@ -89,6 +89,12 @@ enum omap_color_mode {
> > >  	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
> > >  	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
> > >  	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
> > > +	OMAP_DSS_COLOR_NV12	= 1 << 14, /* NV12 format: YUV 4:2:0 */
> > > +	OMAP_DSS_COLOR_RGBA12	= 1 << 15, /* RGBA12 - 4444 */
> >
> > Is this the same as ARGB16? Or is it the same, except alpha value is in
> > the other end? If so, I think the naming should be coherent, and either
> > this should be RGBA16, or ARGB16 should be ARGB12.
> >
> > Then again, if TRM says this is RGBA12, and the other one is ARGB16, I
> > guess we should stick with TRM naming...
> > [Mythri] yes these are the TRM naming conventions. There are 2 formats in ARGB16 , ARGB16-1555 and
> ARGB16-4444.
> 
> Please, use some sane email client with proper quoting. It's quite
> difficult to read your emails.
> 
> > > +	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16-1555 */
> > > +	OMAP_DSS_COLOR_RGBX24_32_ALGN	= 1 << 18, /* 32-msb aligned 24bit */
> >
> > Hmm, what is this?
> > [Mythri] This format is RGBx24-8888 (24-bit RGB aligned on MSB of the 32-bit container). TRM DISPC-
> Table 10-199. DISPC_VID1_ATTRIBUTES , formats.
> 
> I don't have OMAP4 TRM. Is it available from somewhere?
> 
> > > +	OMAP_DSS_COLOR_XRGB15	= 1 << 19, /* xRGB15: 1555*/
> > >
> > >  	OMAP_DSS_COLOR_GFX_OMAP2 =
> > >  		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
> > > @@ -112,9 +118,17 @@ enum omap_color_mode {
> > >  	OMAP_DSS_COLOR_VID1_OMAP3 =
> > >  		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
> > >  		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
> > > -		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
> > > +		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY |
> > > +		OMAP_DSS_COLOR_NV12 | OMAP_DSS_COLOR_RGBA12 |
> > > +		OMAP_DSS_COLOR_XRGB12 | OMAP_DSS_COLOR_ARGB16_1555 |
> > > +		OMAP_DSS_COLOR_RGBX24_32_ALGN | OMAP_DSS_COLOR_XRGB15 |
> > > +		OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBA32 |
> > > +		OMAP_DSS_COLOR_RGBX32,
> >
> > Why do you change OMAP3 modes, if this patch is about supported OMAP4
> > modes?
> > [Mythri] When the additional color formats supported for OMAP4 are added in the OMAP3 modes, There
> is a check in the dispc color-modes for OMAP4 alone to support , OMAP3 would return an error as
> before.
> > Do you suggest add a new OMAP_DSS_COLOR_VID1_OMAP4 instead?
> 
> Well, there's an entry for OMAP2 color modes, and OMAP3 color modes. I
> find it quite strange to modify OMAP3 color modes to include OMAP4
> modes, and then later in code find what are acceptable values. Besides,
> having wrong values in ovl->supported_modes means that omapfb will allow
> user space to select illegal color modes.
> 
> So yes, I think there should be separate entries for OMAP4's color
> modes.
> 
> And _dispc_set_color_mode() shouldn't do complex argument checking for
> different omap versions. It's a low level function, and the arguments
> given to it should be valid.
> 

I shall remove the cpu_44xx check in dispc_set_color mode and make relevant changes in display.h to add OMAP4 colormodes.

>  Tomi
> 
Thanks and regards,
Mythri.
