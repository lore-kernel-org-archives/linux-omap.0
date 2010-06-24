From: Zoltan Gaal <z.gaal@holografika.com>
Subject: USB urb synchronization EL2NSYNC
Date: Thu, 24 Jun 2010 16:50:46 +0200
Message-ID: <4C2370C6.5000108@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail00a.mail.t-online.hu ([84.2.40.5]:12566 "EHLO
	mail00a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab0FXPAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 11:00:30 -0400
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail00a.mail.t-online.hu (Postfix) with ESMTPSA id 32F8D25C21D
	for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:51:13 +0200 (CEST)
Received: from [192.168.0.133] (port=2278)
	by holoiroda.com with esmtpsa (Exim 4.69-NetSys #4)
	id 1ORnlo-0001YS-Ev
	for linux-omap@vger.kernel.org; Thu, 24 Jun 2010 16:51:12 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


We are implementing a driver for our camera device attached through USB
through the extansion connector. The device+driver seems to be working
well on a PC platform using the kernel version 2.6.24. When we try to
move to a labrador, omap device the  camera stops working.

The camera sends the data in ISO mode, and the driver collects them using the
complete calback. On PC it is working fine, but on the Omap device we get EL2NSYNC
errors in the iso_completed callback when we try to resubmit the URBs
(usb_submit_urb) even though the ISO_ASAP transfer mode is used and the
speed/quality of the camera has already been reduced. I've checked the
linux-usb forum and they mentioned a kernel bug and a patch. I've tried
to apply this patch, but it is for the kernel 2.6.25.
(forum thread: http://thread.gmane.org/gmane.linux.usb.general/2852/focus=2966)
  I've also tried to backport some parts (ehci-schedule.c) and it did compile.
But using the patched ehci-schedule.c from  the kernel 2.6.25, it gives more error
and not even the interrupt type communication succeeds. (Maybe some
other files have to be back-ported as well)

Could you please help and do you have any suggestions ?

I know it is quite and old kernel version, but b/c of other support issues
we cannot move to newer version :(.

Thank you,
Zoltan Gaal


