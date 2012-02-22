From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: tps65930: MIC does not work
Date: Wed, 22 Feb 2012 14:38:40 +0300
Message-ID: <CAP3+TEpmOi=UdbVg+PeJQKE25LYTjpGWXgeidUZ+27JzMo3O-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42121 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab2BVLil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 06:38:41 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so8881944lag.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 03:38:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

I use Angstrom Linux with devkit8000 where TPS65930 is installed.
Current kernel version is linux-3.0.17-r115c.

I can't enable MIC working while it worked in 2.6.28-omap and
2.6.32-r78. I suspect the MIC Bias control does not function because I
can't see any voltage level at a microphone jack. Trying to use
alsamixer does not let me achieve the goal.

I already set registers to necessary values (borrowed from working
2.6.28-omap) but no sound is still captured from a mic by arecord
utility.

Please suggest how to fix this issue.

Thanks in advance.
Max
