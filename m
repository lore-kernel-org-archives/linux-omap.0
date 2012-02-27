From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: color phase rotation for ICC profile
Date: Mon, 27 Feb 2012 04:51:20 +0100
Message-ID: <CAFU7RzMLsOiJAYb0wkzXH=QTfu-XVkcSrDpNWZDfSGg4FhsBJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36914 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2B0DvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 22:51:20 -0500
Received: by qcqw6 with SMTP id w6so827989qcq.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 19:51:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
my tft is a little bit blu,
so, changing CPR in omap3 I see I can fix the problem.
I'll try to implement something like this
http://en.wikipedia.org/wiki/Color_calibration#Display .
But I don't find an interface for it neither in the more general FBdev.
I could add an ioctl like OMAPFB_GET_COLOR_KEY,
but arriving to drivers/video/omap2/dss/dispc.c dispc_mgr_set_cpr_coef fucntion.
I have to build/buy a calibration software, but I think I can get
really nice results.
I'll obviously start with sysfs for debug, but I'd like some ideas to
develop "the right thing".

Raffaele
