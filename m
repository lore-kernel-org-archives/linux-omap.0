From: Peter Tseng <tsenpet09@gmail.com>
Subject: TWL scripts, and booting pm-2.6.29 on Beagleboard
Date: Tue, 27 Jul 2010 17:41:24 -0400
Message-ID: <4C4F5284.9050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35270 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab0G0VlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 17:41:01 -0400
Received: by vws3 with SMTP id 3so3791566vws.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Jul 2010 14:41:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello everyone.

I am attempting to get the branch named pm-2.6.29 of Kevin Hilman's
linux-omap-pm repo to boot on a Beagleboard revision B5.

The purpose of this is to apply some patches made by Russ Dill about a
year ago [1] that allow a low-power sleep by adding some TWL scripts. I
have been unable to determine whether these are working with the branch
named pm (I am aware that the second and fourth patch are already
applied, so I only need the first and third), so I figured it was best
to start from the same point that Russ Dill started at, which he reports
is pm-2.6.29

The trouble is that pm-2.6.29 does not boot (I boot from an SD card, use
the config file named omap3_beagle_pm_defconfig, and use u-boot 2009.11)
-- no output is printed after "Uncompressing Linux... done, booting the
kernel."
Normally, I would enable CONFIG_EARLY_PRINTK and provide some resulting
output, but this option seems to be missing from the branch in question.

I asking for help in one of the following:
1) Whether there is any alternative way to get useful output to diagnose
why pm-2.6.29 is not booting.
2) How to apply the patch similarly to the current pm branch. (Have the
relevant sections been moved to a generic file at board-3430sdp.c ? Is
there anything else I need to know? Is there documentation on what
exactly these scripts are doing?)
3) Whether there's any alternative way to achieve the same objectives of
power savings.

I appreciate your support in this.

Peter Tseng

[1]
http://groups.google.com/group/beagleboard/browse_thread/thread/197a8ef6b46cc828/6e98db4cbe2cebaa
