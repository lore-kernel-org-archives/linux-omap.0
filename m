From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects
Date: Tue, 9 Jun 2009 10:23:58 +0200
Message-ID: <200906091023.59112.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <87tz2q63mm.fsf@deeprootsystems.com> <1F18D6510CF0474A8C9500565A7E41A2054552C767@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:52060 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZFIIX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 04:23:58 -0400
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A2054552C767@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: khilman@deeprootsystems.com, paul@pwsan.com, linux-omap@vger.kernel.org

On Tuesday 09 June 2009 10:14:58 Tero.Kristo@nokia.com wrote:
> >-----Original Message-----
> >From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >Sent: 08 June, 2009 20:24
> >To: Jean Pihet
> >Cc: Paul Walmsley; Kristo Tero (Nokia-D/Tampere); linux-omap
> >Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects
> >
> >Jean Pihet <jpihet@mvista.com> writes:
> >> On Monday 08 June 2009 16:59:36 Kevin Hilman wrote:
> >>> Jean Pihet <jpihet@mvista.com> writes:
> >>> > Paul,
> >>> >
> >>> > Here is the updated patch that fixes the Overo build as well.
> >>> > Can you check it?
> >>> >
> >>> > Kevin, can you push it if it is correct?
> >>>
> >>> Can you run it through checkpatch, fix the errors and also merge
> >>> Tero's
> >>> RX51 patch if it looks good to you.
> >>
> >> Ok. I will check. The cause might be the mailer.
> >>
> >> I think we need the omap_cfg_reg calls in the RX51 board
> >
> >file as well,
> >
> >> even if the bootloader has the mux setting already right. That way a
> >> warning will be issued in case of a faulty bootloader. Do you agree?
> >
> >I agree.
>
> Well, this is ok for me too as it does not really change anything. I will
> voice my opinion here though. :)
>
> I find it somewhat weird that we take care of two pads in this fashion out
> of ~350 or so, where in most cases we just assume that the pads are
> configured properly by the boot loader. Should we do the same for every
> pad?
Got your point. This omap_cfg_reg throws a warning if the pad is incorrectly 
configured. The goal is to better track the problem in case of a wrong/older 
bootloader. In the ideal world the bootloader and kernel should match and do 
it all right!

> Does the kernel even boot if the CKE signals are configured 
> incorrectly? I would guess the boot loader will fail to load the kernel
> image into SDRAM in that case.
The kernel boots fine in that case, only the SDRAM contents are not preserved 
when going to low power mode.
>
> -Tero


