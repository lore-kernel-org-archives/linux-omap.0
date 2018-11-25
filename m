From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Sun, 25 Nov 2018 09:14:28 -0800
Message-ID: <20181125171428.GL53235@atomide.com>
References: <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
 <20181125111105.GT6920@n2100.armlinux.org.uk>
 <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181125 16:58]:
> Below changes get traffic going with DMA & g_ether...

Oh cool, if you have dma and g_ether working, you should
test it with a variable size ping test loop :) That should
expose any issues within few minutes.

Below is the test script I was using earlier, the
tusb6010 comment there is probably no longer valid.

Regards,

Tony

8< ----------------
#!/bin/bash

#
# At least tusb6010 dma needs 32-bit aligned buffers.
# That can be done by setting no_skb_reserve with:
# musb->g.quirk_avoids_skb_reserve = 1;
#

device=$1
size=$2
wraps=0

while [ 1 ]; do
	#echo "Pinging with size $size"
	if ! ping -w0 -c1 -s$size $device > /dev/null 2>&1; then
		break;
	fi
	size=$(expr $size + 1)

	if [ $size -gt 8192 ]; then
		wraps=$(expr $wraps + 1)
		echo "wrapping ($wraps) at $size"
		size=1
	fi
done
echo "Test ran up to $size"
