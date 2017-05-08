From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Mon, 8 May 2017 18:12:56 +0300
Message-ID: <10da9ac1-325c-792e-3fa1-ab44405ab1c9@ti.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170503105645.26759-5-peter.ujfalusi@ti.com>
 <20170504194034.GA3489@atomide.com> <20170504210529.GB3489@atomide.com>
 <e7a7db55-753f-7b3b-b2e6-290518e7371b@ti.com>
 <52c733a8-e8d3-abd9-2ea8-f3f91f823b89@ti.com>
 <20170505225523.GD3489@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505225523.GD3489@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Tony,

On 2017-05-06 01:55, Tony Lindgren wrote:
> OK I verified that with the current mainline kernel using dma
> and g_ether and your patches 1 to 3 I can run the variable size
> ping test loop for few minutes before it just stops working and
> I can see the legacy DMA interrupt increase depending on the
> size of the packet. Then I checked with v4.1 kernel, and that
> too seems to have the same issue.
>
> I've also verified running the same variable size ping test with
> your patch 4/4 makes things stop within just a few seconds. The
> script I'm using for ping is below.
>
> Anyways, what we really should ensure here is that the external
> dmarequest line is properly triggering things with dmaengine :)
> That's why I'm a bit worried your patch 4/4.
>
> Oh and I also verified the GPMC timings we're using are the same
> as in production n810 kernel so that should not be the issue.
>
> And using the async access on n800 will not work as it will
> produce corrupt transfer size register the report I posted
> earlier is from n800 allowing it to use async transfers. On
> n810 async transfers may work as I recall it having a newer
> tusb6010 version.

I think I have nailed the issue. I had a bug in the omap-dma 
implementation of the port_window (sigh) and couple of issues in the 
tusb6010/*_omap, not introduced by the series.
The ASYNC access is pretty unstable on n810 as well, I got corruption in 
the XFR_SIZE.
I have been using the g_ncm gadget with 
"musb->g.quirk_avoids_skb_reserve = 1;" to ensure that we are using SYNC 
access.

I'm running your variable ping script for 2 hours now, it wrapped >130 
times already, I also run a standalone ping with 2048 size in parallel, 
the n810 is booted to nfsroot:

# cat /proc/interrupts | grep dma
  29:    9483598      INTC  13 Edge      omap-dma-engine
#

I need to clean up the code as I had debugs (disabled now) and stuff and 
I want to try the tusb6010 changes w/o the DMAengine conversion.

>
> Regards,
>
> Tony
>
> 8< ----------------
> #!/bin/bash
>
> device=$1
> size=$2

+ wraps = 0

>
> while [ 1 ]; do
>         #echo "Pinging with size $size"
>         if ! ping -w0 -c1 -s$size $device > /dev/null 2>&1; then
>                 break;
>         fi
>         size=$(expr $size + 1)
>
>         if [ $size -gt 8192 ]; then

+		wraps=$(expr $wraps + 1)
+		echo "wrapping ($wraps) at $size"

>                 size=1
>         fi
> done
> echo "Test ran up to $size"
>

- Péter
