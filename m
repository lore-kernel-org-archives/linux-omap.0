From: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Subject: Help to run latest kernel on DART-4460
Date: Tue, 25 Mar 2014 17:00:09 +0200
Message-ID: <CANZNk81_oYgpX4k0T28NrJ21NktSgZcjMJ=jY4ng5CqV6B3JoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53019 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaCYPAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2014 11:00:10 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so559994pab.9
        for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2014 08:00:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi! We have a DART-4460 board which is based on TI OMAP4460.
It is shipped by Variscite with linux kernel v3.4.27 (as
/proc/config.gz states; uname -a shows "Linux localhost.localdomain
3.4.0-1489-omap4 #28 SMP PREEMPT Wed Oct 30 10:58:36 IST 2013 armv7l
armv7l armv7l GNU/Linux").
We try to make it work with latest kernel, because we want to get
video4linux interface to the cameras which are attached to the board
by CSI interface. So we need drivers/staging/media/omap4iss/ stuff, if
i understand it correct. This stuff is currently included in
linux-stable master branch (but not in any tag) and in
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

The problem is that the kernel uImage we have prepared doesn't boot.

The config of latest linux-stable kernel i have tried last time:
https://gist.github.com/krieger-od/9a2c6bce5a69d22ca2dd
The serial console output with it:
https://gist.github.com/krieger-od/0fa0f6f6f597b10f95a4

The shipped kernel's config:
https://gist.github.com/krieger-od/55b34ebe3571ae4dd875
The serial console output with kernel shipped by vendor:
https://gist.github.com/krieger-od/32481d718e0519dd0bd9

Could anybody share a working config for recent enough kernel for this
or similar hardware?
Any comments?
We appreciate any help. Thanks in advance.

-- 
Andrey Utkin
