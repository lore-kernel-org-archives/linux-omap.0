From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MUSB Error Handling
Date: Fri, 3 Nov 2017 08:33:08 -0500
Message-ID: <CAHCN7x+ojzXUtHNOJT4bQbpCfXQpNPEx1imS54rbfZw7DXC3jw@mail.gmail.com>
References: <CAHCN7xLeZvqUQSi0Z25Ochwdm+OK5MjaVeiK85Wjhvg1=tp7Kg@mail.gmail.com>
 <20171031183307.GC65@LTA0271908.dhcp.ti.com> <20171102194302.GC28152@atomide.com>
 <CAHCN7xLPhMLn=L1ynPBC-vMyFvL=M4z+i065m6C61oYZ1OfAAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHCN7xLPhMLn=L1ynPBC-vMyFvL=M4z+i065m6C61oYZ1OfAAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 2, 2017 at 2:58 PM, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Nov 2, 2017 at 2:43 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [171031 18:35]:
>>> Hi,
>>>
>>> On Tue, Oct 31, 2017 at 12:56:40PM -0500, Adam Ford wrote:
>>> > We have a situation where occasionally the USB glitches where the D-
>>> > glitches low at or near an end of frame (EOF) or end of packet (EOP).
>>> > We're using the TWL4030 with MUSB on an OMAP3 processor.  We cannot
>>> > tell where the glitch is originating.
>>> >
>>> >  We're working on resolving this in both hardware and software, but I
>>> > was hoping someone might have some insights on how to address it in
>>> > software.
>>> >
>>> > We created a special test fixture to force the D- low for a moment
>>> > during the EOP and EOF to attempt to compare the handling of other USB
>>> > controllers and/or USB hubs.  The reason I think it's unique to the
>>> > MUSB controller or the TWL4030, because we cannot reproduce this issue
>>> > using other USB controllers and/or other USB controllers handle the
>>> > error condition.
>>> >
>>> > On an older, 3.0.x kernel, if we get a glitch on D-, the MUSB
>>> > controller may become unresponsive to the point where a reboot becomes
>>> > required.
>>> >
>>> > Testing this similar scenario with the 4.14-RC kernel, the MUSB
>>> > controller drops the connection and re-enumerates almost immediately,
>>> > which indicates to me that the error handling is getting better (or
>>> > the glitching is reduced somehow).  I have not seen a reboot be
>>> > required.
>>> >
>>> > If I connect the same USB devices to a USB Hub and/or other USB
>>> > controller and attempt to force this same condition with the test
>>> > fixture, the high level USB code does not notice there is an error.
>>> > There is no disconnect, no hanging, no loss of data.
>>> >
>>> > I am not a USB expert, but it seems like we might be able to handle
>>> > the error in software and/or retry if necessary without dropping the
>>> > connection.  Might someone have any ideas or thoughts on how we might
>>> > be able to tweak the software?
>>>
>>> Does the uart console print any log message before re-enumeration happens
>>> with v4.14-rc? is there 'Babble'?
>>>
>
> I enabled the debugging code and there appears to be Babble.
>
>
> #
> # [  850.994201] musb-hdrc musb-hdrc.0.auto: Babble
> [  851.000091] usb 3-1: USB disconnect, device number 2
> [  851.563079] usb 3-1: new full-speed USB device number 3 using musb-hdrc
> [  851.745849] usb 3-1: New USB device found, idVendor=2504, idProduct=0300
> [  851.753082] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  851.760620] usb 3-1: Product: RAW HID
> [  851.765289] usb 3-1: Manufacturer: (redacted)
> [  851.771453] usb 3-1: SerialNumber: 00.0.0
> [  851.785308] cdc_acm 3-1:1.0: ttyACM0: USB ACM device
> [  851.799926] hid-generic 0003:2504:0300.0002: hiddev96: USB HID
> v1.01 Device [RAW HID] on usb-musb-hdrc.0.auto-1/input2
>
>
>
>>> I cannot tell what could cause the glitches, which seems to be analog
>>> related, but I don't think there is any way in software can prevent
>>> dropping the connection. I suspect the glitches cause the babble condition,
>>> then the musb controller drops the connection, but the musb driver
>>> receives the babble event and restarts the enumeration. There is no
>>> software control to prevent the controller to drop the connection when
>>> babble happens.
>
> I am not a USB expert, but it seems like other USB controllers and/or
> USB Hubs don't disconnect and reconnect under the same conditions.
>
>>
>> This sounds like a different issue but because of the glitch on the
>> data lines might be worth checking..
>>
> We're working on that in parallel.  The hardware developers were
> hoping it could be fixed in software, so I thought I'd see if there
> were ways of making the USB software more fault tolerant by doing some
> sort of retry or something.
>
>> It used to be that musb was trying to enumerate as a gadget on it's
>> own, maybe only if the bootloader had some gadget configured.
>
> I am using the g_zero gadget to open the OTG port in host mode.
>>
>> I think this issue is fixed now with commit a118df07f5b1 ("usb: musb:
>> Don't set d+ high before enable for 2430 glue layer"). So just to
>> make sure, have some gadget configured in the kernel for musb while
>> running your tests.
>>
>
> Right now, I'm using the 4.14-RC7 kernel, but the behavior is much
> improved from  that of the 3.0 kernel which would sometimes crash/hang
> the MUSB driver requiring a total system reboot.  Simply unloading and
> reloading the gadget and/or musb modules were not enough.  It seems
> like the 4.14 kernel is much better an noise, but sometime in the hubs
> and/or desktop controllers still seems to handle it better.
>
> If anyone has any other thoughts, I'm willing to try them.
>
> thanks for the feedback guys.
>

One other similar question.  I apologize for my ignorance. It appears
as if the MUSB support suspending and resume in host mode.  If we can
predict that the noise will generate, we're hoping to suspend the USB
before the noise even, then resume the USB after the noise event in
hopes that the USB doesn't disconnect and re-connect again.

Can someone point me to the right place for the documentation on how
to suspend only the USB?  I know how to make the whole system suspend.

Thanks,

adam

> adam
>
>> Regards,
>>
>> Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
