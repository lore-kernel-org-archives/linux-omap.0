From: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Mon, 25 Apr 2011 16:21:31 -0700
Message-ID: <4DB601FB.3000306@gmail.com>
References: <20110411093214.GA18215@rainbow><4DA3350E.2060400@gmail.com><BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com><112ef82aebc719ef25cde126f2014ebc@mail.gmail.com><20110412040420.GB25239@rainbow><bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com><4DB0D58E.4030508@signal11.us><8712165194c49f0b4d8c1bd1fe717b8a@mail.gmail.com><4DB58108.4040708@signal11.us> <BANLkTinn7C2gVKg4v8dbUxo7yYycdFM8PA@mail.gmail.com> <0e9c63ec5ebfd57af1ac3318e436efb9@mail.gmail.com> <4DB5ADFF.5030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DB5ADFF.5030502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Dmitry Artamonow <mad_soft-aPYA7nAdAYY@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/25/11 10:23, Steve Calfee wrote:
> On 04/25/11 09:41, Keshava Munegowda wrote:
>>> -----Original Message-----
>>> From: Steve Sakoman [mailto:sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>>> Sent: Monday, April 25, 2011 7:46 PM
>>> To: Alan Ott
>>> Cc: Keshava Munegowda; Dmitry Artamonow; Steve Calfee; Felipe Balbi;
>> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>>>
>>> On Mon, Apr 25, 2011 at 7:11 AM, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org> wrote:
>>>> On 04/24/2011 02:37 AM, Keshava Munegowda wrote:
>>>>>> -----Original Message-----
>>>>>> From: Alan Ott [mailto:alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org]
>>>>>> Sent: Friday, April 22, 2011 6:41 AM
>>>>>> To: Keshava Munegowda
>>>>>> Cc: Dmitry Artamonow; Steve Sakoman; Steve Calfee; Felipe Balbi;
>>>>> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>>>>>> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>>>>>>
>>>>>> On 04/12/2011 12:20 PM, Keshava Munegowda wrote:
>>>>>>>> Ah, so EHCI/OHCI common code was moved into drivers/mfd... Good.
>>>>>>>> But seems regulators support was lost somewhere during transition
>> -
>>>>> the
>>>>>>>> only mentioning about regulators in omap-usb-host.c is "#include"
>> :
>>>>>>>>
>>>>>>>> mad@macmini:~/kernel-hack/linux-2.6(master)$ grep -i regulator
>>>>>>> drivers/mfd/omap-usb-host.c
>>>>>>> Thanks ! I will add some time next week!
>>>>>> I have confirmed this on my BeagleBoard-xM. 2.6.38 works, but the
>>>>>> 2.6.39-rc4+ head from yesterday did not. It seems that the regulator
>>>>>> does not turn the power on for the USB hub which the ethernet is
>>>>>> attached to.
>>>>>>
>>>>>> I connected this issue to bug 33092 in bugzilla[1].
>>>>>>
>>>>>> Alan.
>>>>>>
>>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=33092
>>>>> I have posted the patches on April 22, 2011.
>>>>> If possible I request you to test this.
>>>>
>>>> Hi Keshava,
>>>>
>>>> If you mean this patch[1], then I tested it against the head and it
>>>> didn't fix my problem. I couldn't convince myself that your patch was
>>>> supposed to be the whole fix to my problem (since it wasn't mentioned
>> on
>>>> this thread) so I didn't reply with my findings. Sorry about that.
>>>
>>> Same here.  The real issue (at least for Overo) turned out to be:
>>>
>>> https://lkml.org/lkml/2011/4/14/45
>>>
>>> Steve
>>
>> But, I was not aware of the fix of the link:
>> https://lkml.org/lkml/2011/4/14/45
>> Sorry for this.
>> Same fix works for beagle-XM and I have tested this.
> 
> I just tried your 3 patches on my beagleboardxm. It still fails to boot.
> Maybe I have a different problem? Your fix did enable usb (at least it
> found the hub and usbnet driver, but the smsc95xx driver may or may not
> be working.
> 
> Here is my failed 2.6.39rc4 boot log. If I back up to 2.6.38 the kernel
> does find the nfs server and starts.
> 
<snip>
> [    4.301788] mmc0: new high speed SDHC card at address 1234
> [    4.310424] mmcblk0: mmc0:1234 SA04G 3.67 GiB
> [    4.321441]  mmcblk0: p1 p2 p3
> [    4.359619] usb 1-2.1: new high speed USB device number 3 using ehci-omap
> [    4.485046] usb 1-2.1: New USB device found, idVendor=0424,
> idProduct=ec00
> [    4.492309] usb 1-2.1: New USB device strings: Mfr=0, Product=0,
> SerialNumbe0
> [    4.505432] smsc95xx v1.0.4
> [    4.596130] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
> usb-ehci-omap.0d
> [   16.620605] Root-NFS: no NFS server address
> [   16.625122] VFS: Unable to mount root fs via NFS, trying floppy.
> [   16.632354] List of all partitions:
> [   16.636230] b300         3858432 mmcblk0  driver: mmcblk
> [   16.641876]   b301         1020096 mmcblk0p1
> 00000000-0000-0000-0000-00000001
> [   16.650634]   b302         1028160 mmcblk0p2
> 00000000-0000-0000-0000-00000002
> [   16.659515]   b303         1807312 mmcblk0p3
> 00000000-0000-0000-0000-00000003
> [   16.668243] No filesystem could mount root, tried:  nfs
> [   16.673767] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unkn


Hi Keshava,

I rebuilt my system to boot from flash and now I see what happened. I
even remember it being discussed on this list. Someone renamed my usb
ethernet device from usb0 to eth0 !!! The boot log shows it on this line:

> [    4.596130] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
> usb-ehci-omap.0d


So this broke my init scripts and uboot script... OK, so I can live with
this (I hope the name doesn't change too often though).

So I can manually configure my system to use eth0 and use the network. I
am sure I will get nfs working shortly.

I am using the 2.6.39-rc4 with your 3 patches. So from the Beagleboard
XM perspective it works and you can include my

Tested-by: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
