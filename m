From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Help to run latest kernel on DART-4460
Date: Tue, 25 Mar 2014 16:17:10 +0100
Message-ID: <CAOf5uwmE_iDpcDBNdC2_kQwn+GkpG=2_eqcB2MQc+Aw8G-H-7w@mail.gmail.com>
References: <CANZNk81_oYgpX4k0T28NrJ21NktSgZcjMJ=jY4ng5CqV6B3JoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33077 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaCYPRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2014 11:17:12 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so416067wgh.28
        for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2014 08:17:10 -0700 (PDT)
In-Reply-To: <CANZNk81_oYgpX4k0T28NrJ21NktSgZcjMJ=jY4ng5CqV6B3JoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi

On Tue, Mar 25, 2014 at 4:00 PM, Andrey Utkin
<andrey.krieger.utkin@gmail.com> wrote:
> Hi! We have a DART-4460 board which is based on TI OMAP4460.
> It is shipped by Variscite with linux kernel v3.4.27 (as
> /proc/config.gz states; uname -a shows "Linux localhost.localdomain
> 3.4.0-1489-omap4 #28 SMP PREEMPT Wed Oct 30 10:58:36 IST 2013 armv7l
> armv7l armv7l GNU/Linux").
> We try to make it work with latest kernel, because we want to get
> video4linux interface to the cameras which are attached to the board
> by CSI interface. So we need drivers/staging/media/omap4iss/ stuff, if
> i understand it correct. This stuff is currently included in
> linux-stable master branch (but not in any tag) and in
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>
> The problem is that the kernel uImage we have prepared doesn't boot.
>
> The config of latest linux-stable kernel i have tried last time:
> https://gist.github.com/krieger-od/9a2c6bce5a69d22ca2dd
> The serial console output with it:
> https://gist.github.com/krieger-od/0fa0f6f6f597b10f95a4
>
> The shipped kernel's config:
> https://gist.github.com/krieger-od/55b34ebe3571ae4dd875
> The serial console output with kernel shipped by vendor:
> https://gist.github.com/krieger-od/32481d718e0519dd0bd9
>
> Could anybody share a working config for recent enough kernel for this
> or similar hardware?
> Any comments?
> We appreciate any help. Thanks in advance.
>

I have already done somenthing like that more then 6 months ago. I was
in a good state, What camera sensors are you using?

Michael

> --
> Andrey Utkin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
