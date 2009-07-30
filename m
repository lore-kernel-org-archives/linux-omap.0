From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: OMAP3 EHCI USB on Beagleboard
Date: Thu, 30 Jul 2009 13:36:06 -0700
Message-ID: <dfb660300907301336i1b1c196dpbd390961370ecd05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:34310 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZG3Ulx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 16:41:53 -0400
Received: by pzk38 with SMTP id 38so656889pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 13:41:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've been trying to get the EHCI USB host port on the beagleboard to
work but with little success. The board initial finds the usb devices
plugged into a hub on boot, but once I'm able to login, I get a
disconnect notice on the hub and the port will no longer recognize any
usb device inserted until reboot. Any ideas what's going on? I'm using
the current master branch of the omap git repo.

Thanks,
Laine Walker-Avina
