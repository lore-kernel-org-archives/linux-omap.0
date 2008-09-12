From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: omapfb not working on beagleboard
Date: Fri, 12 Sep 2008 14:22:50 +0300
Message-ID: <94a0d4530809120422q1f0aaf67hb3a1422e2e631112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:63257 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYILLWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 07:22:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so778166rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 04:22:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was getting bad image with the current omapfb on the Beagle Board
until Mans Rullgard told me to change the bits per pixel to 16.

Is there any reason why it's 24?
drivers/video/omap/lcd_omap3beagle.c

-- 
Felipe Contreras
