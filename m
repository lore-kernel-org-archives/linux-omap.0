From: Enrico <ebutera@users.sourceforge.net>
Subject: Re: YUV422 input to CPI?
Date: Fri, 20 Apr 2012 12:26:46 +0200
Message-ID: <CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
References: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56588 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2DTK0r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 06:26:47 -0400
Received: by vcqp1 with SMTP id p1so6245468vcq.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 03:26:47 -0700 (PDT)
In-Reply-To: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Knopp <simon.knopp@pg.canterbury.ac.nz>
Cc: linux-omap@vger.kernel.org, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On Thu, Apr 19, 2012 at 11:56 PM, Simon Knopp
<simon.knopp@pg.canterbury.ac.nz> wrote:
> Hi all,
>
> I have a camera module capable of outputting YUV422 over a parallel i=
nterface. I've been having some issues interfacing this to a Gumstix. R=
eading through the OMAP3530 tech ref, I'm now beginning to wonder wheth=
er it is actually possible to input YUV422 to the CPI?
>
> - =A0Section 12.1.1 mentions RGB and YeCyMgG for "image sensors"; YUV=
 is only mentioned for CS1&2.
> - =A0On the other hand, 12.4.6.1 says that the CCDC accepts YUV data =
in numerous formats.
>
> Is anyone able to confirm whether it's possible to input YUV422 to th=
e CPI?

Yes it's possible but yuv support is still not in mainline kernel.

Have a look at the linux-media ml archive to know what is the current
status, problems etc...basically if you don't need bt656 support you
can try the omap3isp-omap3isp-yuv branch at [1].

Enrico

[1]: http://git.linuxtv.org/pinchartl/media.git
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
