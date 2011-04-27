From: green@linuxhacker.ru
Subject: Initial B&N Nook Color support
Date: Tue, 26 Apr 2011 21:52:11 -0400
Message-ID: <1303869133-27976-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:56270 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756138Ab1D0CIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2011 22:08:55 -0400
Received: from fatbox1.localnet (fatbox1.localnet [127.0.0.1])
	by fatbox1.localnet (8.14.4/8.14.4) with ESMTP id p3R1qFA9028014
	for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 21:52:15 -0400
Received: (from green@localhost)
	by fatbox1.localnet (8.14.4/8.14.4/Submit) id p3R1qEG0028012
	for linux-omap@vger.kernel.org; Tue, 26 Apr 2011 21:52:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello!

  I am surprised nobody did it sooner given how popular the Nook Color is
  and also considering the price.

  Anyway, here is my initial attempt at adding the support for it to
  the latest kernel.
  The two patches included are the bare bones support that brings serial
  console support, internal MMC + SDCard and also usb client.

  I hijacked the nookcolor mach-type entry since it's for this device,
  but in fact the original device nickname was encore, so this is how
  the arch is named, hopefully this is fine (and hopefully there is a way
  to update the info at http://www.arm.linux.org.uk/developer/machines ).
  Encore name is also somewhat significant due to plenty of existing
  infrastructure depending on it.

  There are still plenty of stuff to add of course including the device
  drivers that probably needs to go through respective subsystem
  maintainers first.
  In this patchset the only updated bit that is not directly relevant to the
  board file is twl4030 that did not know anything about 65921 chip.

Bye,
    Oleg

