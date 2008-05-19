From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Power management behavior of linux-2.6.14-omap2-v5
Date: Mon, 19 May 2008 12:19:07 +0530
Message-ID: <c656a4d20805182349h66efb783pc3b3658a1935ba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:57040 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYESGtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 02:49:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so742393tic.23
        for <linux-omap@vger.kernel.org>; Sun, 18 May 2008 23:49:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I am using linux-2.6.14-omap2-v5 to test PM on 2430SDP.

I did

a) cat myimg > /dev/fb0
    I can see "myimg" displayed on the lcd

b) cat /dev/fb0 > myimg_before_sleep

c) echo "mem" > /sys/power/state
    Board goes to sleep state.

d) After a key press the board awakes and lcd
   becomes blue "myimg" is disappeared from
   the screen.

e) cat /dev/fb0 > myimg_after_wakeup

 The two binary files "myimg_before_sleep" and
"myimg_after_wakeup" differs each other.

Can somebody explain me why such a behavior?
Why the lcd fails to display the same image
before and after sleeping?

Regards,
Arun C
