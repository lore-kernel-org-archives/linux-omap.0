From: tarek attia <tarek.m.attia@gmail.com>
Subject: scaling_setspeed doesn't change the frequency on beagleboard
Date: Wed, 9 Dec 2009 10:55:40 +0200
Message-ID: <82cfbe860912090055y690bf929p269b4a4c9097a687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:56641 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZLIIze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 03:55:34 -0500
Received: by ewy1 with SMTP id 1so3917153ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 00:55:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

I'm using the beagleboard ,and android linux kernel obtained from the
rowboat project .

The cpufreq files are located and everything works fine except that
it doesn't change the frequency it works on,I echo'ed the
scaling_governor to use the userspace .

However it still doesn't change the frequency I'm typing also I'm sure
that my frequency is in the valid range .

What may blocks this changes ?

Any Idea will be appreciated  :)

-- 
tarek
