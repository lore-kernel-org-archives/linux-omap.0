From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 30 Mar 2012 10:26:09 +0100
Message-ID: <WC20120330092609.901834@terrafix.co.uk>
References: <87vcloipow.fsf@ti.com> <WC20120329083556.20174D@terrafix.co.uk> <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com> <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com> <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:56924 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755411Ab2C3J0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 05:26:32 -0400
In-Reply-To: <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

...[snip]...
> 
> Could you please try attached patch and let me know if this solves the
> rx issue as well,
> without using dma mode.
> 

Right,

I think we've getting closer, but still not quite there...

Firstly, the patch adds an include to "iomap.h" - but this doesn't exist in stock 3.3. Simply removing this include seemed to allow the compile to complete 
successfully.

With this patch applied (and not in DMA mode) I now get the following:
  - If I leave wake-from-suspend enabled for the serial port then it works correctly (i.e. no lost/extra 0x00 characters).
  - If I disable wake-from-suspend for the serial port and go through a suspend cycle (i.e. suspend and then wake), then the serial port starts to misbehave as 
before.
  - If I then re-enable wake-from-suspend and go through a suspend cycle it starts to work correctly again.

So the problem is still that if wake-from-suspend is disabled for a serial port, and a suspend cycle is performed then when woken the serial port will not function 
correctly if operating in interrupt-mode.

Cheers,
Joe

> --
> Thanks,
> Govindraj.R


