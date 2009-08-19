From: Suresh Rajashekara <suresh@mistralsolutions.com>
Subject: Where is DSP Gateway
Date: Tue, 18 Aug 2009 21:45:55 -0700
Message-ID: <deb0f030908182145r68b8021cj49f2fac24d330eca@mail.gmail.com>
References: <deb0f030908181654m71a6a10l10a29426377a702a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f204.google.com ([209.85.223.204]:42360 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZHSEpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 00:45:54 -0400
Received: by iwn42 with SMTP id 42so89973iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 21:45:55 -0700 (PDT)
In-Reply-To: <deb0f030908181654m71a6a10l10a29426377a702a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

We had been using dspgateway 3.3 on 2.6.16. Recently we changed our
kernel to 2.6.29 and we found that the dspgateway driver has been
removed from the tree
( http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=2512fd29db4eb09e82d182596304c7aaf76d2c5c).

What do I do, If I want to use the dspgateway on 2.6.29?

I tried searching the patch for dspgateway on 2.6.29, but found none
except this
http://archive.netbsd.se/?ml=linux-kernel&a=2009-07&m=11155350

Any pointers would be really helpful

Thanks in advance,
Suresh
