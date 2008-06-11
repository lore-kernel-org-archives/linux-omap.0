From: Ram <vshrirama@gmail.com>
Subject: query on OMAP3 ISP
Date: Wed, 11 Jun 2008 21:36:19 +0530
Message-ID: <8bf247760806110906n91adfadt1c4491e8e92f17f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:46563 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbYFKQGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 12:06:21 -0400
Received: by py-out-1112.google.com with SMTP id p76so1460140pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 09:06:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
   Has anybody tested/found the exisiting camera port on omap3 with a
ISP sensor
  (ISP is within the sensor) connected through parallel interface working?

  I am trying to port a ISP sensor driver to work on omap3.However i
am unable to
  get any camera interrupts.

   I am using the linux-2.6.22 kernel on linux.omap.com.

   On probing, the mclk and pclk clocks are fine.

   I see HSync, VSync signals and activity on the data lines as well.

   However, i dont get any camera interrupts.

   I am trying to debug the issue.

  Any clues where i should look at?

Regards,
sriram









Regards,
sriram
