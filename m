From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RE: [RFC][PATCH 0/19] Cleanup- custom error codes
Date: Fri, 26 Mar 2010 05:04:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB46@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBEB1C@dbde02.ent.ti.com>
	 <4BABCE66.7080304@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044DEBEB3B@dbde02.ent.ti.com>
 <94a0d4531003251508u1cd3d5f6l85636213b239b9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab0CYXeo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 19:34:44 -0400
In-Reply-To: <94a0d4531003251508u1cd3d5f6l85636213b239b9bb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>



> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Thursday, March 25, 2010 5:08 PM
> To: Hebbar, Shivananda
> Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Ramirez Luna, Omar;
> Felipe Contreras; Palande Ameya (Nokia-D/Helsinki)
> Subject: Re: [RFC][PATCH 0/19] Cleanup- custom error codes
> 
> On Thu, Mar 25, 2010 at 11:37 PM, Hebbar, Shivananda <x0hebbar@ti.com>
> wrote:
> >> love the cleanup *but*:
> >> arch/arm/plat-omap/include/dspbridge/dbdefs.h:typedef u32 dsp_status;
> >> 1) All usage of dsp_status should be changed to int
> >
> > Looks like MM code uses this variable. Even MM code needs to be changed
> for this. But changes are minimal.
> 
> What do you mean by MM uses this variable? If you mean user-space
> (omx, gst-dsp), then no, error codes are passed through ioctl, which
> returns an int.
Ok ignore my previous comment. TI Multimedia code (lcml) uses DSP_STATUS which is again declared in bridge user side header file.

So what Nishanth is referring to can be cleaned up from bridge driver code.

Regards,
Shivananda
