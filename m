From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 09:48:07 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54107 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932783Ab3CVIsM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 04:48:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hello,

I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
channel swapping issue on playback of a stereo stream (one channel has a 
sine, the other is zero); the channel swap occurs on starting the playback

with a scope I have observed that the audio data indeed swaps relative to 
the FSX; so the problem is on the I2S bus

I see the issue with the TWL4030 audio codec; McBSP2 is slave, TWL4030 is 
master

on a custom board I see the same issue with a TLV320AIC3104 on McBSP3 
(have tried to configured the TLV320AIC3104 as slave and master, same 
channel swapping issue for both configs)

the channel swapping issue has been discussed here, 
http://comments.gmane.org/gmane.linux.alsa.devel/82178, and patches have 
been pointed out for 2.6.32

it appears that the swapping issue is back, probably due to the DMA rework 
in recent kernel?

can someone confirm the issue? any suggestions?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
