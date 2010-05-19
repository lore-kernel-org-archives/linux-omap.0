From: Danilo Caravana <danilo.caravana@gmail.com>
Subject: OMAP 3530 - DPLL4 Clock
Date: Wed, 19 May 2010 13:49:14 -0300
Message-ID: <AANLkTilMVZOU8TpocEGIZzI6GA3G5AM0aeg6lgaKBqBy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62780 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab0ESQtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 12:49:17 -0400
Received: by fxm10 with SMTP id 10so2568552fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 09:49:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm using Linux kernel on my OMAP 3530 product, but i need the McSPI
running at exactly 6,5 Mhz.
The problem is that McSPI clocks is derived from DPLL4 which has a 96
MHz output.
I need to change the DPLL4 clock in Linux, and need everything else
working (Except USB, which need 48MHz).
Analysing the kernel code, I couldn't find where the DPLL4 is set, or
how can I change it without screw all others clocks.

Any help would be appreciated.

Thanks,

Danilo M. Caravana
