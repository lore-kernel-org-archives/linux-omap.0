From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Wed, 30 Sep 2009 08:40:23 +0300
Message-ID: <20090930084023.825cba91.jhnikula@gmail.com>
References: <2183bec20909221938mf436e87y7620613e160ae6e2@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com>
	<2183bec20909222202u7ada82e1ycb1de4702822e171@mail.gmail.com>
	<20090924094608.542909b7.jhnikula@gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BADAC2D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:50021 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbZI3FkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 01:40:12 -0400
Received: by ewy7 with SMTP id 7so6107843ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 22:40:15 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BADAC2D9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: hari n <hari.zoom@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 29 Sep 2009 21:28:45 +0530
"Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:

> > Having said that, there is also bug in the DMA driver which doesn't
> > disable the channel in linking cases. Since we use always hardware
> > synchronized method, hardware will take care of draining the buffer so no
> > loss of data.
> > 
> > So option B should be ok and USB case also would work as mentioned above.
> 
> Which option finally we converged on this issue? Shall we fix in the DMA driver or you want to do this in ALSA?
> 
For me it looks that at least the omap_stop_dma should be fixed to stop
ongoing transfer always when it's called. As the name suggest :-)

Then for offmode, if there is no clear method to save & restore
low-level McBSP & DMA context in their drivers, I don't see problem if
e.g. resume handler in sound/soc/omap/omap-mcbsp.c would call
the omap_mcbsp_config etc.


-- 
Jarkko
