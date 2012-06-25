From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Mon, 25 Jun 2012 10:09:28 +0200
Message-ID: <CAAwP0s2WOxT5YM0zbJrBvsoUh2n6wGuahM7ahY5jGOBJkGEJig@mail.gmail.com>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org> <20120625005134.GA2342@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62539 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2FYIJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 04:09:49 -0400
Received: by gglu4 with SMTP id u4so2577915ggl.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 01:09:49 -0700 (PDT)
In-Reply-To: <20120625005134.GA2342@S2101-09.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 25, 2012 at 2:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> It seems the same patch has been there for a while.
>
> http://thread.gmane.org/gmane.linux.kernel/1303115
>
> Regards,
> Shawn
>

Hi Shawn,

Thanks for the info, I first send this patch:
http://www.spinics.net/lists/linux-omap/msg72489.html but Russell
pointed me to the thread:
http://lists.arm.linux.org.uk/lurker/thread/20120523.200015.2fdfd505.en.html
and told me that no patch ever came from his response on the subject.
That's why I sent this patch with Russell suggested approach to solve
the issue. But as you said, it was sent but got lost.

That's a pity since the bug is pretty serious (it deterministically
crashes when trying to reboot the board).

Thanks a lot and best regards,
Javier
