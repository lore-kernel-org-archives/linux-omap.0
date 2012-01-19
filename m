From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 11:37:39 -0800
Message-ID: <87y5t3trek.fsf@ti.com>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35050 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932675Ab2ASTho (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 14:37:44 -0500
Received: by yenl9 with SMTP id l9so239580yen.35
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 11:37:43 -0800 (PST)
In-Reply-To: <WC20120119122128.020787@terrafix.co.uk> (Joe Woodward's message
	of "Thu, 19 Jan 2012 12:21:28 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

"Joe Woodward" <jw@terrafix.co.uk> writes:

[...]

> If I do (either from the console or via a button press on the screen)
> then I never get a SYNC_LOST.
>
>   echo 0 > /sys/devices/omapdss/display0/enabled
>   echo 1 > /sys/devices/omapdss/display0/enabled
>
> Just trying to think of some ideas that may be affecting the DSS...
>   - Could it to be to do with the GPIO being used as a wake source (i.e. does the GPIO driver do runtime_pm properly?)?
>   - Could it to be to do with the UART as it seems to fix itself whenever a character is pressed?
>   - Could it to be to do with the ordering in which drivers are resumed?

Here's my guess/hunch as to why the UART wakeup helps and GPIO doesn't.

The UART's are idled using timeouts, so after any activity (including a
wakeup) the UART timeout will not alow the UARTs to idle (and thus the
system to hit low power states) for a given timeout period.

I don't know what DSS does on wakeup, but presumably it has a burst of
activity to do right away.  Because of the UART timeout, the DSS
probably completes its "burst" of activity before the system ever idles
to a low power state.

With a GPIO wakeup, the system can (re)idle and possibly hit low power
states immediately after the wakeup.

If that is the case, that suggests that the DSS probably needs a
constraint someplace to prevent this from happening, at least during
this "burst" period.

Kevin
