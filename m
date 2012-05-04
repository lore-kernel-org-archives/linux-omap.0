From: Kevin Hilman <khilman@ti.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next, working on 3.2
Date: Fri, 04 May 2012 09:27:35 -0700
Message-ID: <87397fewso.fsf@ti.com>
References: <20120504155255.140b4e3f@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36163 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751958Ab2EDQ1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 12:27:42 -0400
Received: by pbbrp8 with SMTP id rp8so4034269pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 09:27:33 -0700 (PDT)
In-Reply-To: <20120504155255.140b4e3f@skate> (Thomas Petazzoni's message of
	"Fri, 4 May 2012 15:52:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> I have an IGEPv2 revision 6 board, which uses the DM3730 OMAP3. With
> 3.2 omap2plus_defconfig, the system boots fine and have a working shell
> on ttyO2. On either 3.3, 3.4-rc5 or arm-soc/for-next from Arnd, the
> system boots all the way up to showing the shell prompt, but I can't
> type any character, as if UART RX was broken.

On v3.4-rc, can you see if reverting bce492c04ba8fc66a4ea0a52b181ba255daaaf54
has any effect?

That patch had some unfortunate side effects, but I haven't seen the
problem you see, so I'm not sure if it's related.

Kevin
