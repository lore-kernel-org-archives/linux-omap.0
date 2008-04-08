From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Tue, 8 Apr 2008 15:06:03 +0800
Message-ID: <386072610804080006g588c7ad9ya4dd8c9c9c6cf827@mail.gmail.com>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com>
	 <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com>
	 <200804070905.10048.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:26793 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbYDHHGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 03:06:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1487718wra.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Apr 2008 00:06:04 -0700 (PDT)
In-Reply-To: <200804070905.10048.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Apr 8, 2008 at 12:05 AM, David Brownell <david-b@pacbell.net> wrote:
> On Monday 07 April 2008, Felipe Balbi wrote:
>  > I recall having some issues on 100mA devices. During enumeration some
>  > current spikes a few mAs above 100mA were occuring and we couldn't
>  > enumerate the device due to vbus_err interrupt.
>
>  Yeah, I think the Mentor core is unduly sensitive to voltage
>  fluctuation during enumeration.  There's supposed to be about
>  100 msec before VBUS must stabilize ... but the silicon doesn't
>  seem to accept routine instabilities in that period, and then
>  reports inappropriate VBUS errors.
>

For this VBUS error, Blackfin MUSB port follows other platforms idea to retry.

But to this bug, the ZiO card reader will trigger the mode change
maybe due to the VBUS drop.
It should be different as the VBUS error in the enumeration, because
the enumeration of the ZiO
is OK.

And for our development board EZKIT548, it can provide 500mA current
at 5V as it claimed in manual
with a external regular. So from my point of view, this bug is not
related with 100mA current limit issue.

>
>
>  > If you check drivers/usb/musb/tusb6010.c you'll see that we've
>  > implemented a retry condition for those cases. The same retry can
>  > be found in musb_core.c
>
>  The DaVinci support needed the same kind of logic.  All in
>  all this is painful stuff to sort out, and it seems that
>  each platform rediscovers it.  It would be better if the
>  silicon itself weren't fighting back so hard...
>

Yes, I reported this to our silicon designers.

-Bryan
