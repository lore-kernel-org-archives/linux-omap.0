From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS : DSI checksum error
Date: Mon, 22 Aug 2011 13:13:16 +0300
Message-ID: <1314007996.2168.39.camel@deskari>
References: <CAHzTB4vN4UK2FwPKNf-nKdbUfgF6KAidu-twZidCeE_huVmsxA@mail.gmail.com>
	 <CAHzTB4vGdCr-ps0gcNdCvKz7Q-CeOUZf9PCcUW=xsCvrSP9V0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:40007 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753084Ab1HVKNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 06:13:21 -0400
Received: by mail-bw0-f52.google.com with SMTP id zs2so5591111bkb.11
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 03:13:19 -0700 (PDT)
In-Reply-To: <CAHzTB4vGdCr-ps0gcNdCvKz7Q-CeOUZf9PCcUW=xsCvrSP9V0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sudipta GHOSH <sudipta.in@gmail.com>
Cc: linux-omap@vger.kernel.org, archit@ti.com

Hi,

Most likely it is caused by electrical interference with the transfer.
Or, while very unlikely if it happens only rarely, a HW bug in the panel
(or even in OMAP).

 Tomi

On Mon, 2011-08-22 at 13:05 +0300, Sudipta GHOSH wrote:
> Moi Tomi,
> 
> Have you ever encounter this error.
> 
> Looking some pointer what can cause checksum error.
> 
> Regards,
> Sudipta
> 
> On 18 August 2011 17:35, Sudipta GHOSH <sudipta.in@gmail.com> wrote:
> > Hi,
> >
> > Working DSS & Panel driver.
> >
> > Sometime I am getting checksum error from DSI when framebuffers are
> > sent to panel via DSI.
> >
> > omapdss DSI error:       ACK with ERROR (0x400):
> >
> > Wanted to know if some one has encounter similar error.
> >
> > When / what can cause this error?
> >
> > Regards,
> > Sudipta
> >


