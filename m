From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Mon, 25 Nov 2013 21:44:21 +0100
Message-ID: <5293B6A5.3040607@gmail.com>
References: <Pine.LNX.4.44L0.1311251534260.1172-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1311251534260.1172-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/25/2013 09:41 PM, Alan Stern wrote:
> On Mon, 25 Nov 2013, Daniel Mack wrote:
> 
>>>>> What if you have a mounted file system on a pendrive ? Should we allow
>>>>> suspend in that case ?
>>>>
>>>> Well, I would have expected that, but in fact, the opposite is true.
>>>> With 3.12, mounting a filesystem on a USB media and accessing it after
>>>> resume was exactly my test case, and it worked just fine with that patch.
>>>
>>> so you had a mounted file system, suspend, resume, it was still mounted?
>>
>> Yes, exactly.
>>
>>> or did it reenumerate and you remounted it ?
>>
>> No, it did not reenumerate, but the core did a reset on it. See the
>> following log.
> 
> ...
>> [   32.030792] usb 1-1: reset high-speed USB device number 2 using
>> musb-hdrc <<<< !
> 
> Like I said, you get a reset-resume.

Yup. We can't avoid losing VBUS on this platform, and even if we could,
we wouldn't want that, in order to save as much power as possible.

>>> Try to do the same with transfers in flight, it's likely to corrupt your
>>> file system.
> 
> It's not so easy to suspend a system with USB mass-storage transfers in 
> flight.  For one thing, userspace gets frozen before the suspend 
> starts, so there's nothing to initiate new I/O requests (except perhaps 
> for dirty-block writebacks).
> 
> Also, the child SCSI device gets suspended before the USB device, so
> its I/O queue stops running.  In addition, the usb-storage suspend
> routine and the main I/O thread are mutually exclusive (they both grab
> the private mutex), so a suspend can't occur while a SCSI command is
> underway.

Thanks Alan for the explanation. That was my understanding as well.


Best regards,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
