From: Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 07 May 2015 13:17:44 -0500
Message-ID: <554BAC48.2050406@logicpd.com>
References: <554AA11B.9040909@logicpd.com> <20150507160606.GB15563@atomide.com> <20150507161656.GB29183@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150507161656.GB29183-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi -

On 05/07/15 11:16, Felipe Balbi wrote:
> Hi,
>
> On Thu, May 07, 2015 at 09:06:06AM -0700, Tony Lindgren wrote:
>> * Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org> [150506 16:19]:
>>> Hi all -
>>>

*snip*

>>>
>>> Something about this feels race conditiony too.  Depending on the kernel
>>> configuration options in the kernel debug menu (which slows down other parts
>>> of the kernel), or if I enable verbose debug message output from the MUSB
>>> driver, it lasts much, much longer before keeling over as a system.  You can
>>> restore normal behavior by unplugging/replugging in the device.
>>
>> This sounds like some issue dealing with certain size transfers where
>> there's data remaining after a DMA transfer. You might be able to make
>> it easily reproducable with a variable size ping from your PC even with
>> debugging enabled. Something like the script below.
>>
>> Regards,
>>
>> Tony
>>
>> 8< --------------
>> #!/bin/bash
>>
>> device=$1
>> size=$2
>>
>> while [ 1 ]; do
>> 	#echo "Pinging with size $size"
>> 	if ! ping -w0 -c1 $device -s$size > /dev/null 2>&1; then
>> 		break;
>> 	fi
>> 	size=$(expr $SIZE + 1)

(This line should have referred to $size instead of $SIZE.)

>>
>> 	if [ $size -gt 8192 ]; then
>> 		size=1
>> 	fi
>> done
>>
>> echo "Test ran up to $size"
>
> I'd be very much interested in getting such logs :-)
>

Unfortunately, the driver works with the script above (after fixing the 
one line) so it's not a "certain size" style scenario.

Using iperf I can get traffic to stop flowing within a second of usage 
so fortunately it's highly reproducible.  One thing I tried this morning 
was to simply "ignore" the fact the RXCSR register didn't have the 
expected bit and continue in the driver.  While the throughput was 
abysmal (and DMA "errors" were reported), at least the driver didn't 
die.  I could still ping after stopping iperf.  (I don't think this is 
the appropriate thing to do, but it was just a quick and dirty test.)

However, iperf does have the ability to adjust the packet size while 
still spewing out a high-rate (configurable bandwidth) of packets. 
Armed with this, I modified the ping test above to utilize iperf instead 
at various packet sizes (granted, this would get fragmented above the 
MTU size by the IP stack), leaving it at 1000 packets per second.

Doing that as an exercise with the Ethernet dongle, it first keeled over 
at 1059 byte UDP datagrams (1101 bytes on Ethernet - I don't know how 
many USB transactions this split into exactly), at 1000 packets per 
second.  However, it doesn't consistently keel over at the same bytes 
per datagram.  Another attempt keeled over at 1052 byte UDP datagrams.

Upping the ante to 1500 packets per second, and jumping at 16-byte 
intervals for the size, it lasted from 1000 to 1352 byte size packets 
and keeled over at 1368 byte sized packets.

Some of the configurations of iperf against MUSB in DMA mode causes the 
ASIX driver (the Ethernet dongle driver) to complain too, even to the 
point of doing a NULL dereference (I will dig into this dereference). 
Not seen with the MUSB in PIO mode.

Note: Same system/kernel, configured as an Ethernet gadget does not 
exhibit the issues, although, I'm not convinced it's actually using DMA 
for this.  INTC 93 does not have any activity as a gadget (INTC 92 gets 
all the traffic).  I can improve the performance (~35% improvement) in 
PIO mode of an Ethernet gadget by configuring the dynamic FIFO in the 
MUSB to utilize double buffering, but DMA mode still falls over with a 
USB ethernet dongle attached with double buffering.  I haven't tried the 
series of iperf bandwidth tests against double buffering yet.  I also 
have the idle loops in the system disabled to improve interrupt latency 
("nohlt cpuidle.off=1").

- Tim


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
