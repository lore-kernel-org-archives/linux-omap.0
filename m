From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: am335x crypto module clocks
Date: Sun, 5 Apr 2015 06:17:58 +0200
Message-ID: <CAALWOA8Zno6pTfWRZpacgWm83m4=1+uvTmyREG9Nc+C2MZjK1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38599 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbDEESU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 00:18:20 -0400
Received: by wiun10 with SMTP id n10so4582135wiu.1
        for <linux-omap@vger.kernel.org>; Sat, 04 Apr 2015 21:18:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

To my surprise, the am335x clock tree (am33xx-clocks.dtsi) currently
lists the functional clock of the AES accelerator and other crypto
modules to be the (max 26 MHz) main osc. This struck me as rather
unlikely, since the AES module is clocked much higher on other
devices, and such a slow clock would condemn it to being slower than a
software AES implementation.  As usual the TRM is silent on the crypto
accelerators and their clock management, but I did some preliminary
tests.

The AES module turned out far from slow.  I actually had a lot of
trouble keeping the module continuously fed with data with a simple
non-dma test from userspace, since for most modes of operation the AES
module could even keep pace with a tight loop using 128-bit neon
load/store without even checking its status register for readiness.

Although I haven't been able to get obtain a very reliable measurement
yet as a result, it appears to be clocked at ~200 MHz. This also
matches the fact that it is hooked up to the L3F (which would be
rather pointless if it had a separate low-rate fck).

It seems very likely to me the other crypto modules will also have a
unified fck/ick (L3F for the hash accelerator, L4LS for the RNG and
PKA). This should preferably still be double-checked of course.

Matthijs
