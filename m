From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Bringing back gptimer_wakeup
Date: Mon, 18 Jun 2012 11:18:04 +0200
Message-ID: <4FDEF24C.8020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44504 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751836Ab2FRJUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 05:20:49 -0400
Received: by lahd3 with SMTP id d3so3349967lah.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 02:20:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The support for using a timer to wake from suspend was removed in:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864

I found an alternative patch 
(http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html) 
that claimed to keep it working using GPTIMER1 instead, but I haven't 
been able to make it work (likely because the timer code has changed a 
good deal since the patch was posted).

Anyone got
a) a patch that enables this feature on newer kernels, or
b) an idea how the patch above can be made to work?

Regards,
Tasslehoff
