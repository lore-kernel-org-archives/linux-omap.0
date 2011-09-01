From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: devkit8000 & omap3stalker LCD panel
Date: Thu, 01 Sep 2011 09:42:12 +0300
Message-ID: <1314859332.1933.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37929 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429Ab1IAGmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 02:42:19 -0400
Received: by mail-bw0-f41.google.com with SMTP id zt4so1455210bkb.28
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 23:42:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lzg@ema-tech.com, weber@corscience.de
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Thomas, Jason,

I noticed that both devkit8000 and omap3stalker boards use the generic
dpi driver for LCD. Why is that? If the boards have a normal fixed
resolution LCD, the timings for the LCD should be added to the
panel-generic-dpi.c.

 Tomi


