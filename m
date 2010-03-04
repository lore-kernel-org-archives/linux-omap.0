From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: OMAPFB: cannot parse default modes
Date: Thu, 4 Mar 2010 16:25:03 +0100
Message-ID: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39087 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab0CDPZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 10:25:03 -0500
Received: by pvb32 with SMTP id 32so384212pvb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Mar 2010 07:25:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello,

Testing the Linux Omap master branch on IGEP v2 board I get this feature

[   17.565155] omapfb omapfb: cannot parse default modes

My kernel command line is something like  '..
omapfb.mode=dvi:1280x720MR-24@60' which works without problems with
latest 2.6.33-rc8. Any idea about this ? There is something different
between 2.6.33 and 2.633-rc8 ? I'm missing something ?

Thanks in advance,

Enric
