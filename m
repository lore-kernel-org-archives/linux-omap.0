From: "Suresh Rajashekara" <suresh@mistralsolutions.com>
Subject: Suggestion for a new kernel version
Date: Mon, 10 Nov 2008 16:27:03 -0800
Message-ID: <deb0f030811101627s2f5093c0nf79d14bf6e03ca3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:39743 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYKKA1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 19:27:04 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1059959ywe.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:27:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@mistralsolutions.com

Hi List,

We have been using 2.6.16-rc3-omap1 on one of our OMAP1 based product
which had quite a few bugs. We had been taking some fixes from the
later kernels and port it back, but at some point it becomes difficult
to do it when the basic data structures changes (because any such big
changes are frowned upon if proposed for a working product), but now,
finally we have decided to change the kernel itself to some later
version. I would appreciate if the list can suggest us some kernel
version to which we can switch to. Requirements are;

1. Kernel should be pretty stable (very less bugs)
2. Even if there are any bugs, it should be easy to port the fixes
back. This is important because I don't get a chance to convince the
decision makers to change the kernel again because its something which
is very basic and they are afraid to change a working system for a
small bug fix.

Some of the components for which we depend heavily on the kernel are
MTD/JFFS2 (with which we have faced lot of issues in
2.6.16-rc3-omap1), DSP Gateway functionality and power management.

Thanks in advance for your help.

- Suresh
