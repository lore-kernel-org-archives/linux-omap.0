From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Wed, 7 Oct 2009 14:42:55 -0700
Message-ID: <20091007214254.GA29320@atomide.com>
References: <2183bec20909221938mf436e87y7620613e160ae6e2@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com> <2183bec20909222202u7ada82e1ycb1de4702822e171@mail.gmail.com> <20090924094608.542909b7.jhnikula@gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BACC566F@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702F9E7DA66@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53325 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZJGVnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 17:43:40 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9E7DA66@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, hari n <hari.zoom@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [090924 05:59]:
> 
> 
> >-----Original Message-----
> >From: Shilimkar, Santosh
> >Sent: Thursday, September 24, 2009 2:24 AM
> >To: Jarkko Nikula; hari n
> >Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> >Subject: RE: [OMAP3] ALSA driver 'suspend/resume' handlers
> >
> >Hari/Jarkko,
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> >> Sent: Thursday, September 24, 2009 12:16 PM
> >> To: hari n
> >> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> >> Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
> >>
> >> On Wed, 23 Sep 2009 00:02:01 -0500
> >> hari n <hari.zoom@gmail.com> wrote:
> >>

<snip>

> >omap_stop_dma() should be issued when we really want to stop the DMA transfer and issuing this with
> >an outstanding transfer is a BUG in ALSA driver.
> >
> >Having said that, there is also bug in the DMA driver which doesn't disable the channel in linking
> >cases. Since we use always hardware synchronized method, hardware will take care of draining the
> >buffer so no loss of data.
> >
> >So option B should be ok and USB case also would work as mentioned above.
> 
> USB is not a valid use case to discuss here.
> Mentor OTG controller has its internal DMA and so does EHCI/OHCI host controller.
> USB on OMAP3 _does_not_ use system DMA.

At least tusb6010 connected to 2420 on n800 and n810 uses the system DMA.

Tony
