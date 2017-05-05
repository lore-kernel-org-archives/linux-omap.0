From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Fri, 5 May 2017 15:55:23 -0700
Message-ID: <20170505225523.GD3489@atomide.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170503105645.26759-5-peter.ujfalusi@ti.com>
 <20170504194034.GA3489@atomide.com>
 <20170504210529.GB3489@atomide.com>
 <e7a7db55-753f-7b3b-b2e6-290518e7371b@ti.com>
 <52c733a8-e8d3-abd9-2ea8-f3f91f823b89@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52c733a8-e8d3-abd9-2ea8-f3f91f823b89@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170505 08:20]:
> On 2017-05-05 16:37, Peter Ujfalusi wrote:
> > On 2017-05-05 00:05, Tony Lindgren wrote:
> > > And this sync gpmc issue seems to be timing related. Setting
> > > DEBUG in tusb6010_omap.c makes it happen easily while without
> > > it it's much harder to trigger. So probably some kind of issue
> > > with GPMC sync timings.
> > 
> > Indeed there are some interesting things happening...
> > As I said, I was testing with g_cdc (CDC Composite (ECM + ACM)) and I
> > found it pretty stable with DMAengine. But short story long:
> > 
> > With the series applied and getting rid of the dma_addr & 0x2, plus
> > setting the set the quirk_avoids_skb_reserve flag:
> > g_cdc (ECM + ACM) boots to nfsroot most of the time, ping, scp works
> > g_ether (ECM) does not boot to nfsroot, ping does not work. However if I
> > disable the rx DMA with:
> > 
> > diff --git a/drivers/usb/musb/tusb6010_omap.c
> > b/drivers/usb/musb/tusb6010_omap.c
> > index 8b43c4b99f04..8e0a19b47132 100644
> > --- a/drivers/usb/musb/tusb6010_omap.c
> > +++ b/drivers/usb/musb/tusb6010_omap.c
> > @@ -512,6 +512,12 @@ tusb_omap_dma_allocate(struct dma_controller *c,
> >          return NULL;
> >      }
> > 
> > +    if (!tx) {
> > +        dev_err(musb->controller, "Not allowing RX DMA for ep%i %s\n",
> > +            chdat->epnum);
> 
> Remove the %s and s/chdat/hw_ep
> 
> and the kernel will not crash :( But still not booting with DMAengine when
> RX DMA is disabled :o

OK I verified that with the current mainline kernel using dma
and g_ether and your patches 1 to 3 I can run the variable size
ping test loop for few minutes before it just stops working and
I can see the legacy DMA interrupt increase depending on the
size of the packet. Then I checked with v4.1 kernel, and that
too seems to have the same issue.

I've also verified running the same variable size ping test with
your patch 4/4 makes things stop within just a few seconds. The
script I'm using for ping is below.

Anyways, what we really should ensure here is that the external
dmarequest line is properly triggering things with dmaengine :)
That's why I'm a bit worried your patch 4/4.

Oh and I also verified the GPMC timings we're using are the same
as in production n810 kernel so that should not be the issue.

And using the async access on n800 will not work as it will
produce corrupt transfer size register the report I posted
earlier is from n800 allowing it to use async transfers. On
n810 async transfers may work as I recall it having a newer
tusb6010 version.

Regards,

Tony

8< ----------------
#!/bin/bash

device=$1
size=$2

while [ 1 ]; do
        #echo "Pinging with size $size"
        if ! ping -w0 -c1 -s$size $device > /dev/null 2>&1; then
                break;
        fi
        size=$(expr $size + 1)

        if [ $size -gt 8192 ]; then
                size=1
        fi
done
echo "Test ran up to $size"
