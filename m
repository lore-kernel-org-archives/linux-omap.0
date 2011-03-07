From: Steve Sakoman <sakoman@gmail.com>
Subject: USB issues with 2.6.38-rc7?
Date: Sun, 6 Mar 2011 20:58:47 -0800
Message-ID: <AANLkTi=icn1QeM7pTZhVNLAcsHaJO-eyp-EHm5QWVvOf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38797 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab1CGE6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 23:58:48 -0500
Received: by vxi39 with SMTP id 39so3441940vxi.19
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 20:58:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I began working with mainline 2.6.38-rc7 on Overo this past week in an
attempt to get a few patches submitted in time for the 2.6.39 merge
window.

One thing I've noticed is that neither musb nor ehci USB support are
working for me.  I'm using the same config options as I did for
2.6.37.

Have there been changes made to the USB subsystem that require board
file or config changes?  A search of this list hasn't turned up any
likely candidates, but it wouldn't be the first time my search skills
failed me!

Steve
