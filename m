From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: linux omap on sdp broken?
Date: Fri, 18 Sep 2009 21:42:00 -0500
Message-ID: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:52750 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZISCsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 22:48:47 -0400
Received: by bwz6 with SMTP id 6so1051950bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 19:48:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi Folks,
Has Anyone tried booting latest kernel from tmlind master tree recently?
Ref: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

Starting kernel ...
Uncompressing Linux.................................................................................................................................................................
done, booting the kernel.

Gets stuck there..
Tried with
arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Also tried 2008q3 with no luck.

Regards,
Nishanth Menon
