From: Steve Sakoman <sakoman@gmail.com>
Subject: ASoC broken on 3.2-rc4?
Date: Wed, 7 Dec 2011 12:58:14 -0800
Message-ID: <CAGDS+nmW+fgo20znqdQch9Uvu7Q9=p1D0AwPqx4vjakXZ6PiAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53260 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab1LGU6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 15:58:15 -0500
Received: by vcbfk14 with SMTP id fk14so860131vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Dec 2011 12:58:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I just began working with 3.2-rc4 on Overo and Beagleboard xM.

On both machines I see the driver init, but no alsa device created.
For example on Overo:

Advanced Linux Sound Architecture Driver Version 1.0.24.
<snip>
overo SoC init
ALSA device list:
  No soundcards found.

Has anyone else seen this?  Just want to make sure it isn't a known
issue before digging in and debugging.

Steve
