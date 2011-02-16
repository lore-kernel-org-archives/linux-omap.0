From: Sung Hee Park <shpark7@stanford.edu>
Subject: omap3evm does not boot after 2.6.38-rc1
Date: Wed, 16 Feb 2011 14:19:05 -0800
Message-ID: <AANLkTi=GHh-UTfTHgDJKW8HfCbTbe6zqitAL0FeyXtW8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60124 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab1BPWTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 17:19:06 -0500
Received: by wwa36 with SMTP id 36so1903823wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 14:19:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm having a problem with booting the linux kernel on my omap3evm. It
halts after saying "Uncompressing Linux... done, booting the kernel."
on boot. I had a similar problem with 2.6.37, but after changing the
name of the serial port devices from /dev/ttyS* to /dev/ttyO*, it
worked. Does anyone experiencing this problem again with 2.6.38
kernels? Please let me know if you have any idea what might have gone
wrong.

Regards,
Sung Hee Park
