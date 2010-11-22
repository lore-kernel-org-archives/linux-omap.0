From: James Adams <james.r.adams@gmail.com>
Subject: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 13:14:17 +0000
Message-ID: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41261 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0KVNOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 08:14:19 -0500
Received: by qwc9 with SMTP id 9so794632qwc.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 05:14:19 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

We are running Android on a custom Gumstix Overo Water platform. We
have ported the 25.12 Zoom2 release to do this.

It is almost working except that when trying to decode H264 videos
with resolution above 640x480 (either horizontally or vertically, e.g.
640*544) the DSP module appears to crash. Decoding anything at VGA or
below is working fine.

DSP bridge is configured with 0x600000 memory (but larger doesn't seem
to help).  Is anyone aware of other configuration options that we
should be checking (e.g. in DSP bridge, OMAP video drivers, or
android?) that might cause large video decodes to fail?

Thanks in advance,

James
