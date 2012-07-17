From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 17 Jul 2012 21:57:38 +0530
Message-ID: <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53614 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2GQQ1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 12:27:40 -0400
Received: by lbbgm6 with SMTP id gm6so822036lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 09:27:38 -0700 (PDT)
In-Reply-To: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <a0393947@ti.com>

[CC'ing OMAPDSS matinainer]

On 17 July 2012 19:31, Raphael Assenat <raph@8d.com> wrote:
> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>
Display panels are board specific and there is no limit to the number
of panels that could be connected to omap dss.
 Does it make sense to get panel params via DT? Or at least have them
come from board file? (esp when there is hardly a panel shared by two
boards, and some panels aren't even used by any board in mainline)
