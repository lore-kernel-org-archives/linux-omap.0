From: onlyfever <onlyfever@gmail.com>
Subject: How to loopback two PCM interface?
Date: Sun, 24 Jul 2011 21:18:06 +0800
Message-ID: <CAGoEaev6Gr2n7A3VT0P+=F=hARRCYF1FgH6t3Z-ptHEjenVGCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62506 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab1GXNSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Jul 2011 09:18:08 -0400
Received: by vws1 with SMTP id 1so2485169vws.19
        for <linux-omap@vger.kernel.org>; Sun, 24 Jul 2011 06:18:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi,
    I configure McBSP3 and McBSP4 as PCM interface.
    I want to connect two PCM interface internally.
   The data captured from PCM1 can be directly sent to PCM2 playback interface.
    How can I achieve that?
    Please give me some advise.

thank you!
