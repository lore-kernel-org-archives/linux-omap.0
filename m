From: Ash Charles <ashcharles@gmail.com>
Subject: DT support for OMAP3 ISP
Date: Tue, 6 Jan 2015 12:42:12 -0800
Message-ID: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:51285 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbAFUmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 15:42:43 -0500
Received: by mail-ig0-f178.google.com with SMTP id b16so216286igk.17
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 12:42:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

Hi,

I'm playing with the Caspa camera (mt9v032) and Overo on the 3.17
kernel.  It looks like there has been some work on dt-bindings for the
omap3isp (notably [1] and [2]) but I didn't see anything heading for
mainline.

What would be needed to support cameras using the omap3isp in a mainline kernel?

Thanks for any insight,
--Ash

[1] https://github.com/vaussard/linux/commits/overo-for-3.14/iommu/dt-v2
[2] http://git.linuxtv.org/cgit.cgi/sailus/media_tree.git/log/?h=rm696-043-dt
