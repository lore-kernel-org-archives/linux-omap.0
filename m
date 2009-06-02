From: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Subject: DSS2: How to test TV and LCD output simulatenously
Date: Mon, 1 Jun 2009 21:24:18 -0500
Message-ID: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34652 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369AbZFBCYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 22:24:25 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

Hi,
I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.
Now I am trying to get output both on TV and LCD simultaneously, 

I was not successful with my approach that I tried, like

1. Boot the kernel with the default LCD display
2. Then I enabled ntsc timings for TV, as PAL do not work on it. 
    #echo ntsc > /sys/devices/platform/omapdss/display1/timings
3. Enabled TV
  # echo 1 > /sys/devices/platform/omapdss/display1/enable
and did the common fb test....
But it did not seem to work.
Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.

Regards,
Subbu

