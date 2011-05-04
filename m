From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Wed, 04 May 2011 14:05:53 +0300
Message-ID: <1304507153.2099.31.camel@deskari>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-5-git-send-email-mayur@ti.com>
	 <1304448293.26126.29.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DA742E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33931 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094Ab1EDLF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 07:05:57 -0400
Received: by mail-fx0-f45.google.com with SMTP id 2so904290fxm.32
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 04:05:56 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DA742E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

On Wed, 2011-05-04 at 15:31 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: Valkeinen, Tomi
> > Sent: Wednesday, May 04, 2011 12:15 AM
> > To: Janorkar, Mayuresh
> > Cc: linux-omap@vger.kernel.org; K, Mythri P
> > Subject: Re: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
> > 
> > On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> > > The configurations and data transfer with picodlp panel happens through
> > i2c.
> > > An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> > >
> > > dpp2600 requires 4 gpio lines for interfacing it with any processor,
> > > phy_reset, ready_reset, park, display_select
> > 
> > Hmm, so what is dpp2600? It's mentioned here for the first time, the
> > documentation doesn't mention it.
> 
> Patch 0 does mention about dpp2600. It means DLP Pico Processor
> and I have also provided link to wiki page which talks more about dpp2600.
> Earlier version of patch also had functions dpp2600_configure_flash.

Remember that patch 0 is just an intro for the patch set. It's not
included in the kernel tree. So the basic rule is that patch 0 should
not contain any important info that is not available from the patches
itself.

Where does the DPP2600 name come from? The documentation doesn't mention
it, it's only mentioned in the wiki page written by you. I didn't find
anything with a quick googling either.

> > If it means the picodlp, just use the same name all the time. If not,
> > you could tell what it is first.
> 
> DPP means DLP pico processor.

So DPP is the processor part inside the projector? I'm not sure if that
knowledge is relevant here. From the kernel driver's point of view
there's just the projector, where the GPIOs, i2c and video lines go.
Does it matter that there's a DPP2600 processor inside?

Also, in the patch comment above you write "picodlp panel". The PicoDLP
is not panel, so you shouldn't speak of picodlp panel.

 Tomi


