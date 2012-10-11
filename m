From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: omap DSS fails with tft410 driver panel?
Date: Thu, 11 Oct 2012 17:58:54 +0200
Message-ID: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61203 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2JKP6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 11:58:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1887251pad.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 08:58:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>

Hi all,

I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
changes the panel driver used on some boards. I tested current
linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
following error (see http://pastebin.com/VjPGCQDt for full log) :

   [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be 0
   [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be 0
   [   21.236236] omapfb omapfb: setup_plane failed

Before checking what happens there is a known issue with this ?

Thanks in advance,
    Enric
