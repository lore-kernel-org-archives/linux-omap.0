From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Wed, 18 Aug 2010 19:16:15 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE1F300C@dbde02.ent.ti.com>
References: <1280987665-25639-1-git-send-email-mythripk@ti.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
	 <1282042850.2348.42.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE1F2E1B@dbde02.ent.ti.com>
	 <1282122106.2348.110.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE1F2FC0@dbde02.ent.ti.com>
 <1282137179.2348.152.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50327 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab0HRNqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 09:46:24 -0400
In-Reply-To: <1282137179.2348.152.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

I shall check if the OMAP4 TRM is public and get back to you.
Here is the excerpt of the TRM , for the color modes.

DISPC_VID1_ATTRIBUTES
Bits Field Name Description Type Reset
4:1 FORMAT Video Format. RW 0x0
It defines the pixel format when fetching the video #1
picture into memory.
0x6: RGB16-565
0x1: RGB12x-4444
0xA: YUV2 4:2:2 co-sited
0x7: ARGB16-1555
0xD: RGBA32-8888
0x0: NV12 4:2:0 2 buffers (Y + UV)
0x2: RGBA12-4444
0x8: xRGB24-8888 (32-bit container)
0x9: RGB24-888 (24-bit container)
0xB: UYVY 4:2:2 co-sited
0x5: ARGB16-4444
0xF: xRGB15-1555
0xC: ARGB32-8888
0x4: xRGB12-4444
0xE: RGBx24-8888 (24-bit RGB aligned on MSB of the
32-bit container)

Thanks and regards,
Mythri.

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, August 18, 2010 6:43 PM
> To: K, Mythri P
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> 
> Hi,
> 
> On Wed, 2010-08-18 at 14:52 +0200, ext K, Mythri P wrote:
> > Hi Tomi,
> > 	Sorry I configured my email client :).
> > 	Here is the link for OMAP4 TRM :
> > http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
> 
> That is for OMAP34xx...
> 
>  Tomi
> 

