From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: tps65930 microphone fails in 3.0.17
Date: Sat, 25 Feb 2012 23:14:29 +0300
Message-ID: <CAP3+TEoCNpVkG3zPM9s2ZQExcku5B+ccvNVu3fL0y+UrX=joeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64466 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757648Ab2BYUOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Feb 2012 15:14:31 -0500
Received: by lagu2 with SMTP id u2so4016082lag.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Feb 2012 12:14:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi colleagues!

I'm working with Angstrom Linux where the kernel 3.0.17-115c is
currently used. I use a Beagleboard clone with TPS65930 installed
instead of TPS65950 on Beagle. Recently I've been using 2.6.32 and a
Microphone feature worked fine after applied patches for Devkit8000 to
the registers set for TPS65930 in twl4030.c. The problem appeared in
the latest kernel 3.0.17 where setting registers to correct values
does not enable a Microphone recording. Specifically I don't see the
MIC BIAS functioning while I enabled in MICBIAS_CTL (voltage level is
zero at allmicrophone pins).

The default alsamixer supplied with Angstrom distribution does not let
to manage the Microphone bias.

Please suggest a direction to follow..

best wishes,
Max
