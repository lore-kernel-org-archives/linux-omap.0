From: Emanoil Kotsev <deloptes@yahoo.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 21:08:26 -0700 (PDT)
Message-ID: <962792.40418.qm@web53204.mail.re2.yahoo.com>
References: <20080803025600.GB8304@kroah.com>
Reply-To: deloptes@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web53204.mail.re2.yahoo.com ([206.190.49.74]:22251 "HELO
	web53204.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750896AbYHCEI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Aug 2008 00:08:28 -0400
In-Reply-To: <20080803025600.GB8304@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Ok, so I've installed 2.6.26 and tested most of the hardware I use. Except hfs everything seems to be working better than with 2.6.24 and much better then 2.6.20 as expected.

I'll give it a try with my server, as you say you do a lot of testing ... and after the hole discussion, I'm understanding your point of better now.

My basic problem is that I'am testing a kind of solution I had in mind time ago, but it still fails for some reason even with the patched 2.4.24 version. I gave it up and didn't test 2.6.25 because I was pretty buzy recently. Now I see it's hard to catch up.

My problem is the follwing one and the question is if it will disapear after I install 2.6.26, or is it a hardware issue. I think somehow the drive does not behave as the others drives I use over usb. I'm using mostly seagate, but this one is WD:

hub 7-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb usb4: suspend_rh (auto-stop)
usb usb5: suspend_rh (auto-stop)
usb usb6: suspend_rh (auto-stop)
usb usb7: suspend_rh (auto-stop)
ub(2.3): dir r len/act 4096/0 [sense 0 00 00] retry 1
ehci_hcd 0000:00:0e.2: port 3 high speed
ehci_hcd 0000:00:0e.2: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
usb 2-3: reset high speed USB device using ehci_hcd and address 3
usb 2-3: events/0 timed out on ep0in len=0/64
usb 2-3: events/0 timed out on ep0in len=0/64
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0008
ehci_hcd 0000:00:0e.2: devpath 3 ep0in 3strikes
ehci_hcd 0000:00:0e.2: devpath 3 ep0in 3strikes
ehci_hcd 0000:00:0e.2: GetStatus port 3 status 001002 POWER sig=se0 CSC
hub 2-0:1.0: logical disconnect on port 3
ub(2.3): usb_lock_device_for_reset failed (-19)
hub 2-0:1.0: state 7 ports 4 chg 0008 evt 0008
ehci_hcd 0000:00:0e.2: GetStatus port 3 status 001803 POWER sig=j CSC CONNECT
hub 2-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
usb 2-3: USB disconnect, address 3
end_request: I/O error, dev ubd, sector 0
Buffer I/O error on device ubd, logical block 0
end_request: I/O error, dev ubd, sector 0
Buffer I/O error on device ubd, logical block 0
...
...
...
...
Buffer I/O error on device ubd, logical block 0
ldm_validate_partition_table(): Disk read failed.
end_request: I/O error, dev ubd, sector 0
Buffer I/O error on device ubd, logical block 0
end_request: I/O error, dev ubd, sector 0
end_request: I/O error, dev ubd, sector 0
end_request: I/O error, dev ubd, sector 0
Dev ubd: unable to read RDB block 0
end_request: I/O error, dev ubd, sector 0
end_request: I/O error, dev ubd, sector 0
end_request: I/O error, dev ubd, sector 24
end_request: I/O error, dev ubd, sector 24
end_request: I/O error, dev ubd, sector 0
end_request: I/O error, dev ubd, sector 0
 unable to read partition table
usb 2-3: unregistering device
usb 2-3: usb_disable_device nuking all URBs
usb 2-3: unregistering interface 2-3:1.0
usb 2-3:1.0: uevent
usb 2-3: uevent
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:0e.2: port 3 high speed
ehci_hcd 0000:00:0e.2: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
usb 2-3: new high speed USB device using ehci_hcd and address 4
ehci_hcd 0000:00:0e.2: port 3 high speed
ehci_hcd 0000:00:0e.2: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
usb 2-3: default language 0x0409
usb 2-3: uevent
usb 2-3: usb_probe_device
usb 2-3: configuration #1 chosen from 1 choice
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: uevent
drivers/usb/core/inode.c: creating file '004'
usb 2-3: new device strings: Mfr=2, Product=3, SerialNumber=1
usb 2-3: Product: USB to Serial-ATA bridge
usb 2-3: Manufacturer: Sunplus Technology Inc.
usb 2-3: SerialNumber: WDC WD5000     WD-WMASY0076274
ub 2-3:1.0: usb_probe_interface
ub 2-3:1.0: usb_probe_interface - got id
 ubd: ubd1
usbcore: registered new interface driver ub
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.


--- On Sun, 8/3/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: USB driver issue
> To: "Emanoil Kotsev" <deloptes@yahoo.com>
> Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
> Date: Sunday, August 3, 2008, 4:56 AM
> On Sat, Aug 02, 2008 at 05:11:51PM -0700, Emanoil Kotsev
> wrote:
> > Greg, the discussion is getting out of control.
> 
> Hm, looks normal to me :)

Well, "normal" is relative anyway

> 
> > I think you are one of the few that understand what we
> are talking
> > about (may be not compleetly but at least you are not
> confronting with
> > statements that make me angry) and it seems that you
> are trying to
> > find a compromise. So I'll write only this one
> mail and get out of
> > this discussion.
> > 
> > First I do not consider 2.6.22 new, but it would be
> nice to have
> > longer life cycles.
> 
> Why?  What good would that do?  How would we, as a
> community, support
> such a thing?  Do you really understand how the kernel
> development
> process works and how fast it moves?

Yes I am understanding better. I am pretty happy with it. The problem is that I have a feeling (and not only me) that it's at the cost of reliability, but I should admit that response and fixes have also improved.

The question is how could be found a relativ stable compromise between "latest" and "stable" and I think the best option is the vendors kernel, which is maintained by the OS vendor. For testing purposes and recent features (that are to be expected mostly on newer hardware like notebooks etc) the latest version could be installed and tested, because you are focused on it and I don't want to argue against.

> 
> > The problem is that we talk to different 3rd party
> vendors who re
> > willing to help but can not follow this speed and the
> changes you do.
> 
> No, there is no "problem" here.  The 3rd party
> vendors are EXPLICITLY
> not wanting to work within our development process for a
> variety of
> reasons.  Again, there is _NOTHING_ that we can do about
> this.
> 
> They are the ones who do not want to work with us, or abide
> by our
> license.  They are the leaches on our community and
> investment and cause
> us nothing but pain and problems.  We have offered to do
> their work for
> them, for free, for the rest of time, and they do not take
> us up on it.
> What else can we do except ignore them as they really do
> not want to do
> ANYTHING to help change the current situation?

some of them changed their mentality and opinion, but still the drivers are comming later as desired. Though I agree that you or me can not do anything about it. At theend it's still an issue.
Appreciate your (I mean the community) desire to help.

> 
> > At the other hand the kernel needs more testing to
> step to next level
> > of development.
> 
> "next level"?  What do you mean by this?  What
> would this level entail?

Forget it it's obsolate idea, I am coming to the conclusion that I'm writing to the wrong people. From your perspective (and for sure you have a good reason) you are doing the right thing. Somehow there was a turbulence around 2.6.20 till now, but may be it's for good. I hhhope I'll know soon.


> 
> Is Linux somehow not working properly for the world? 
> It's in over 80%
> of the TOP500 supercomputers and in all of Motorola's
> new phones,
> a flexibility never before achieved by any type of
> operating system in
> the history of computing.

thumbs up - the big make a profite but I have a headache

> 
> And why do you not think we have a lot of testing?  There
> is a TON of
> testing that happens for new releases.  Sure, we can always
> use more,
> and welcome you to help out if possible.
> 
> Take a moment to try to understand how we do development
> here.  After
> that, please try to describe exactly what you feel we are
> doing wrong,
> and how we could change to make you feel better, in detail,
> given our
> constraints.

>From my perspective I can not afford the time to follow up. It was possible until 2.6.20 got out but since then I simply can not. The boost in kernel development is really remarkable and I agree that's it's even phenomenal, but I need a relaiable kernel for a server, so "latest" version is not an option and obviously you are the wrong people to discuss with, as I agree that you have your own vision and it's possibly for a good reason.
My desire was to have the attention of the developers from let's say 1-2 versions behind. So while you consider 2.6.26 stable you may fix bugs still found in => 2.6.24, but if it is not possible then there are always different options

So I think I will be using the vendors kernel and bug them if I have an issue with it, when it comes to reliability for example conserning server etc.

The second thing is that (in my example and I don't think I am alone out there) there is misunderstanding who is supporting what and at which level.

I don't know how it could be done, if possible at all, but it's pretty confusing sometimes.
>From user perspective obiously a kernel 2.6.22 is not old and from your perspective it is. I think the best way is to explain why you think so and I and other did explain what our major problem is. So I was hoping to find a solution in the middle, and now I think this could be the OS vendor.

Thanks for the patience and thank you in advance if you can find out what's wwrong with this external drive

regards

> 
> thanks,
> 
> greg k-h


      
