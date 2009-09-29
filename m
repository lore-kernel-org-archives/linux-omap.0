From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Tue, 29 Sep 2009 21:28:45 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BADAC2D9@dbde02.ent.ti.com>
References: <2183bec20909221938mf436e87y7620613e160ae6e2@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com>
	<2183bec20909222202u7ada82e1ycb1de4702822e171@mail.gmail.com>
 <20090924094608.542909b7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36897 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZI2P6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 11:58:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, hari n <hari.zoom@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hari,
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Thursday, September 24, 2009 12:54 PM
> To: 'Jarkko Nikula'; hari n
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: RE: [OMAP3] ALSA driver 'suspend/resume' handlers
> 
> Hari/Jarkko,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> > Sent: Thursday, September 24, 2009 12:16 PM
> > To: hari n
> > Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> > Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
> >
> > I don't see any problem if suspend and resume callbacks are added into
> > omap-pcm.c and omap-mcbsp.c calling e.g. omap_mcbsp_config if needed.
> 
> omap_stop_dma() should be issued when we really want to stop the DMA
> transfer and issuing this with an outstanding transfer is a BUG in ALSA
> driver.
> 
> Having said that, there is also bug in the DMA driver which doesn't
> disable the channel in linking cases. Since we use always hardware
> synchronized method, hardware will take care of draining the buffer so no
> loss of data.
> 
> So option B should be ok and USB case also would work as mentioned above.

Which option finally we converged on this issue? Shall we fix in the DMA driver or you want to do this in ALSA?


Regards,
Santosh
