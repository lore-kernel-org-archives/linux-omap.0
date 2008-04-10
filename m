From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Thu, 10 Apr 2008 19:24:50 +0800
Message-ID: <386072610804100424l46273f0en9cc531dd7ec876ee@mail.gmail.com>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com>
	 <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com>
	 <200804070905.10048.david-b@pacbell.net>
	 <386072610804080006g588c7ad9ya4dd8c9c9c6cf827@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:26437 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYDJLYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 07:24:51 -0400
Received: by el-out-1112.google.com with SMTP id v27so2090857ele.17
        for <linux-omap@vger.kernel.org>; Thu, 10 Apr 2008 04:24:50 -0700 (PDT)
In-Reply-To: <386072610804080006g588c7ad9ya4dd8c9c9c6cf827@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Apr 8, 2008 at 3:06 PM, Bryan Wu <cooloney@kernel.org> wrote:
> On Tue, Apr 8, 2008 at 12:05 AM, David Brownell <david-b@pacbell.net> wrote:
>  > On Monday 07 April 2008, Felipe Balbi wrote:
>  >  > I recall having some issues on 100mA devices. During enumeration some
>  >  > current spikes a few mAs above 100mA were occuring and we couldn't
>  >  > enumerate the device due to vbus_err interrupt.
>  >
>  >  Yeah, I think the Mentor core is unduly sensitive to voltage
>  >  fluctuation during enumeration.  There's supposed to be about
>  >  100 msec before VBUS must stabilize ... but the silicon doesn't
>  >  seem to accept routine instabilities in that period, and then
>  >  reports inappropriate VBUS errors.
>  >
>
>  For this VBUS error, Blackfin MUSB port follows other platforms idea to retry.
>
>  But to this bug, the ZiO card reader will trigger the mode change
>  maybe due to the VBUS drop.
>  It should be different as the VBUS error in the enumeration, because
>  the enumeration of the ZiO
>  is OK.
>
>  And for our development board EZKIT548, it can provide 500mA current
>  at 5V as it claimed in manual
>  with a external regular. So from my point of view, this bug is not
>  related with 100mA current limit issue.
>
>

These days I tried hard to workaround this issue, but failed:

- When VBUS_ERR happens in OTG_A_HOST state and the OTG is in
peripheral mode, I try to start a new session and power on VBUS.
- CONNECT IRQ fired and OTG is switch back to host mode.
- In CONNECT IRQ handler, I rescan the musb->endpoint[i].in_qh or
musb->endpoint[i].out_qh. Then resume the urb transfer which was
stopped by the wrong VBUS_ERR mode switch IRQ. or just dequeue the urb
to call off the transfer.
- But the ZiO does not reply anymore. No IRQ from USB hardware. World
keeps silence.

I think this kind of devices maybe should be added to the blacklist of
the musb otg driver.

Do you guys have some idea about that?

Thanks a lot
-Bryan Wu
