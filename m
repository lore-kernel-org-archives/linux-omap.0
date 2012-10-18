From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Thu, 18 Oct 2012 08:00:09 -0700
Message-ID: <20121018150009.GT5378@xanatos>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-2-git-send-email-vikas.sajjan@linaro.org>
 <20121016100656.GB17416@arwen.pp.htv.fi>
 <CAD025yRD+u+z=SEtJvEY+NAdNtg8_cWcCMWaa347e-idmb6GpQ@mail.gmail.com>
 <20121016135328.GI21801@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121016135328.GI21801-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 16, 2012 at 04:53:28PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 16, 2012 at 05:10:39PM +0530, Vikas Sajjan wrote:
> > Hi Felipe, 
...
> did you have a transfer going through when you suspended ? If you
> didn't, then you haven't stressed well enough.
> 
> > 2) We tested by running  command
> > echo +20  > /sys/class/rtc/rtc0/wakealarm  &&  echo mem > /sys/power/state
> 
> that's ok, but try something like:
> 
> # dd if=/dev/urandom of=/dev/sdXX bs=1M count=99999999 &
> # echo +20  > /sys/class/rtc/rtc0/wakealarm  &&  echo mem > /sys/power/state
> 
> Better yet, generate a big (and I really mean big :-) file with a known
> pattern (make a sequence from 0x00 to 0xff and back to zero, over and
> over again) then write that file to the mass storage device, while
> transfer is on the fly, suspend, then resume and see if transfer
> continues, then later verify the bytes by reading back the data and
> comparing with original source file.
> 
> Do this for both Host and Peripheral roles. I have a rather big
> suspicion that it won't work, in which case we need to make sure to
> prevent suspend while transfers are on the fly or do something else.

For system suspend while the DW3 hardware is in host mode, doesn't the
USB core prevent drivers from submitting URBs just before the
PCI/platform suspend is called?  Alan?

If the USB core doesn't quiesce URBs before system suspend, then we
probably have a larger issue that the generic xHCI driver should take
care of.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
