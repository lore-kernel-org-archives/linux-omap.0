From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] usb: dwc3: ep0: Fix mem corruption on OUT transfers
 of more than 512 bytes
Date: Tue, 9 Jun 2015 21:44:06 +0530
Message-ID: <557710CE.5050304@ti.com>
References: <Pine.LNX.4.44L0.1506091114340.1324-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1506091114340.1324-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 09 June 2015 08:46 PM, Alan Stern wrote:
> On Tue, 9 Jun 2015, Kishon Vijay Abraham I wrote:
>
>>> Why not just make the bounce buffer size the same as the maxpacket
>>> size?  In other words, 1024 bytes instead of 512, for ep0 on a USB-3
>>> device.
>>
>> It would still be possible for the host to send data more than 1024 bytes no?
>
> Yes.
>
>> When working with DFU gadget, I've seen host sends data upto 4KB. Changing the
>> bounce buffer size might not be able to fix all the cases IMO. The actual fix
>> will be something like [1]
>>
>> [1] -> http://comments.gmane.org/gmane.linux.kernel/1883688
>
> But with a bounce buffer that's only 512 bytes long, you can never send
> an entire packet's worth of data.  If the bounce buffer is 1024 bytes

for control endpoint, 512 bytes should be sufficient to send entire packet right?
> then you can send the entire first packet.  When that's done, you can
> send the second packet.  And so on.  It wouldn't be quite as fast, but
> for ep0 that shouldn't matter.

right! this is a variant of what I tried to implement in chained TRB [1]. 
$subject tries just to avoid memory corruption instead of actually trying to 
receive all the data.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
