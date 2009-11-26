From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Thu, 26 Nov 2009 16:23:23 +0100
Message-ID: <D68B8539-B8CA-458C-B135-BB5430EAE75E@student.utwente.nl>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:30377 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbZKZPXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 10:23:33 -0500
In-Reply-To: <1259245214.2438.460.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Eino-Ville Talvala <talvala@stanford.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Op 26 nov 2009, om 15:20 heeft Tomi Valkeinen het volgende geschreven:

>> My kernel bootargs are:
>> mem=128M console=ttyS0,115200n8 noinitrd rw root=/dev/mmcblk0p2
>> rootfstype=ext2 rootdelay=1 nohz=off omapfb.rotate=1 omapfb.vrfb=y
>> omapfb.debug=y omapdss.debug=y

Try allocating some more VRAM for fb0 and fb1 and change 'rootdelay=1' to 'rootwait' and remove 'nohz=off'

regards,

Koen