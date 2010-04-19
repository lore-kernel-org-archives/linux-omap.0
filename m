From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: Upstream linux-omap kernel on Nokia N900?
Date: Mon, 19 Apr 2010 14:23:39 +0200
Message-ID: <878w8jr5pw.fsf@small.ssi.corp>
References: <87iq7nslvo.fsf@small.ssi.corp> <20100419115855.GG3544@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:35761 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab0DSMXj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 08:23:39 -0400
In-Reply-To: <20100419115855.GG3544@nokia.com> (Felipe Balbi's message of
	"Mon, 19 Apr 2010 15:00:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Leukkunen Lauri (Nokia-D/Helsinki)" <lauri.leukkunen@nokia.com>, "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>

Hi,

Felipe Balbi <felipe.balbi@nokia.com> writes:

> On Mon, Apr 19, 2010 at 01:49:15PM +0200, ext Arnaud Ebalard wrote:
>>Nokia N900 is shipped to users with a 2.6.28 omap kernel. Many patches
>>for the hardware and various features have been pushed upstream by Nokia
>>developers and possibly others. Those are now available in current l-o
>>tree.
>>
>>Nonetheless, many drivers and various features are still missing
>>upstream. Simply put, one cannot expect to run a current l-o kernel on
>>the device (and expect to get a GUI and/or make call with the device).
>
> tell me about it :-p
>
> Thing is that it doesn't really depend only on Nokia to get those
> parts done. Well, we can get the kernel part done by just cleaning up
> and porting the 2.6.28 drivers to current mainline, but in case of
> e.g. SGX we still miss the xorg driver and I don't think that'll be
> released any time soon.

I agree. I also spotted SGX code as the main obstacle and I started
wondering at how "kernel-independent" it was. IIRC, it is possible to
make it compile againt current l-o with only limited changes. Maybe TI
developers can provide some hints.

The other main obstacle was the code to interface with the phone stack
(SSI MacSAAB, CMT stuff). Felipe, do you know if someone @nokia has some
more recent version available which could be shared if there is good
news from TI on SGX aspect.

> Another problem is that the bootloader believes it can pass all the
> obsoleted OMAP TAGs to kernel and the 2.6.28 kernel depends on those,
> maybe that can be worked around. I don't know whether kernel simply
> drops invalid TAGs or not...

Well, with the first patches (simple update from the ones in official
kernel) in my set, I think that I managed to get getbootstate happy,
i.e. get /proc/bootreason available.

> Good work anyways... At least it's now documented ;-)

Thanks.

> PS:
>
> BTW, CBUS isn't really necessary for n900 and I have almost 40 patches
> cleaning that up pending in this mailing list :-p

yep, I kept it in my series file (cbus-support.patch) as uneeded.

Thanks for your work,

a+
