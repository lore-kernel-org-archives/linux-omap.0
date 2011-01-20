From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on OMAP3 EVM
Date: Thu, 20 Jan 2011 20:56:43 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F9B2239@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755760Ab1ATP0s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 10:26:48 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Hi all
While testing audio capture (using arecord e,g.),I'm getting only noise in the (zeroed out) output buffers on the OMAP3 EVM.
I have enabled AUXL and AUXR mic inputs through alsamixer, which according to the schematics are connected to the "Audio In"
connector on the board, even though the TWL4030 reg list does not allow me any ways ( or so I think) to specify mic-bias for 
these aux inputs.
With AUXL and AUXR muted - I get only silence, which seems to make sense.
Is there any basic startup setting I'm missing, maybe specific to OMAP3 EVM?
Has anyone seen anything like this before, and could provide pointers?

I'm running a kernel based on 2.6.37-rc7 and audio playback is working fine for me.




Thanks in advance
Abhilash
