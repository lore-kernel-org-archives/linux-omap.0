From: John Garland <johnnyg@cse.unsw.edu.au>
Subject: Hang on boot
Date: Mon, 11 Oct 2010 14:09:31 +1100
Message-ID: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39310 "EHLO
	note.orchestra.cse.unsw.EDU.AU" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753090Ab0JKDQB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Oct 2010 23:16:01 -0400
Received: From
	mail-wy0-f174.google.com ([74.125.82.174]) (auth-user johnnyg) (cse-authentic-sender johnnyg)
	(for <linux-omap@vger.kernel.org>) By note With Smtp ;
	Mon, 11 Oct 2010 14:09:55 +1100
Received: by wye20 with SMTP id 20so100697wye.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 20:09:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Both the dspbridge and master branch of linux-omap seem to hang when
trying to boot (i.e. no output) on a beagleboard C2.
This is with the new omap2plus_defconfig (as opposed to the old
omap3_defconfig).

Is anybody else experiencing this or does anyone have any idea what
could be causing this?

Cheers,
John.
