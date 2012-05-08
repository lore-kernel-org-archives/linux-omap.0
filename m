From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Broken UART I/O wakeups on v3.4-rc4+
Date: Tue, 8 May 2012 14:43:56 +0530
Message-ID: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
References: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:60856 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211Ab2EHJOS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 05:14:18 -0400
Received: by obbuo19 with SMTP id uo19so10556349obb.12
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 02:14:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Govindraj,
>
> After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: OMA=
P2+:
> UART: Fix incorrect population of default uart pads"), the kernel doe=
s not
> return from static suspend when off-mode is enabled upon an incoming
> serial character.
>
> The following steps reproduce the problem:
>
> echo 1 > /debug/pm_debug/enable_off_mode
> echo mem > /sys/power/state
> (send a serial character after suspend is entered)
>
> (N.B., on the BeagleBoard, the GPIO-connected "USER" button can be us=
ed to
> wake the system at this point.)
>

The same is discussed in this thread as in here:
http://www.spinics.net/lists/linux-omap/msg68659.html

> Could you please fix this? =A0We probably aren't too far from the v3.=
5 merge
> window opening, so there isn't much time to fix it.

okay, one possible solution is to probe pins dynamically
and make rx wakeup capable which myself and Tony
discussed and came up with this patch [1]

or to add rx wakeup pad support for each board,
based on uart used as console.

--
Thanks,
Govindraj.R

[1]: http://www.spinics.net/lists/linux-omap/msg67822.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
