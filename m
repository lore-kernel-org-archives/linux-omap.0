From: Roger Quadros <rogerq@ti.com>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 12:57:08 +0200
Message-ID: <50F68784.8050708@ti.com>
References: <20130109092915.1c2077b5@notabene.brown> <50F67A50.5020203@ti.com> <20130116212715.2567d5ed@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36619 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab3APK5x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 05:57:53 -0500
In-Reply-To: <20130116212715.2567d5ed@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org

On 01/16/2013 12:27 PM, NeilBrown wrote:
> On Wed, 16 Jan 2013 12:00:48 +0200 Roger Quadros <rogerq@ti.com> wrote:
> 
>> On 01/09/2013 12:29 AM, NeilBrown wrote:
>>>
>>> Hi,
>>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
>>>
>>> My current stumbling block is USB.  The "Option" GSM module is attached via
>>> USB (there is a separate transceiver chip attached to port 1 which is placed
>>> in OMAP_EHCI_PORT_MODE_PHY).
>>>
>>> After a suspend/resume cycle with off_mode enabled the GSM module disappears.
>>> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices don't
>>> exist.
>>> Without off mode, the modem always appears after resume.
>>>
>>> I discovered that the registers set by:
>>>
>>>    drivers/mfd/omap-usb-host.c
>>>
>>> are not maintained across as suspend/resume so I added the following patch
>>> (which I can make a formal submission of if it looks right to others), but
>>> that didn't help (or didn't help enough).
>>>
>>> If I
>>>
>>>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
>>>
>>> thus keeping just the USBHOST power domain out of off_mode, the GSM module
>>> doesn't disappear.  So it seems that some context in the usbhost domain is
>>> not being save and restored.
>>>
>>> This is as far as I can get.  Can someone suggest where I should look to find
>>> out what is not being saved/restored properly, and how to go about saving and
>>> restoring?
>>
>> You need to ensure that USBHOST/TLL context is saved as per the Save and
>> Restore sequence see section "USBHOST/USBTLL Save-and-Restore
>> Management" in the OMAP Technical Reference Manual.
>>
>> The basic idea there is that software does the context saving into SAR
>> RAM before entering OFF mode and hardware automatically restores the
>> context after coming out of OFF mode.
> 
> Is it?  The way I read the doco, the hardware both saves to SAR RAM, and
> restores from  SAR RAM.
>   Section 22.2.4.1.6  Save and Restore
> of my copy of the TRM says:
> 
>> The save-and-restore (SAR) mechanism can extract the hardware context of the high-speed USB host
>> controller (after all USB activity has been suspended) before switching off (=save), save it to an external
>> always-on memory, and reinject it later after the module has been switched on again and reset (=restore)
>> seamlessly for the USB. Part of that context is composed of the register fields described in the current
>> chapter. The rest of the context is composed of the "buried" flip-flops and memories (not accessible by
>> software) like finite state-machine (FSM) states, buffer contents, and miscellaneous random logic bits.
> 
> which strongly suggests that it is all handled by hardware.  Of course there
> are other registers that aren't covered  by the SAR - we need to identify
> those and make sure they are saved and restored.  I've found a few registers
> that aren't being restored, but restoring them hasn't made a visible
> difference yet.

Yes, you are right. I mixed it up with OMAP4 behaviour, sorry.
But still, software needs to ensure that the USBHOST and CORE power
domain's SAVEANDRESTORE bit are set to ensure that SAR works.

see section "3.5.4.6 USBHOST/USBTLL Save-and-Restore Management"

This seems to be done by the powerdomain code based on the
PWRDM_HAS_HDWR_SAR flag. However, this flag is disabled for USBHOST
powerdomain with the following comment.

> Both USBHOST and USBTLL support a save-and-restore mechanism. When the device enters into off
> mode (that is, all power domains, except the WKUP power domain, are off), the user may want to save
> the USBHOST context and restore it when exiting off mode. The save-and-restore mechanism for the HS
> USB Host is enabled by setting the PRCM.PM_PWSTCTRL_USBHOST[4] SAVEANDRESTORE bit; for
> the USBTLL, it is configured by the PRCM.PM_PWSTCTRL_CORE[4] SAVEANDRESTORE bit. The save
> mechanism is initiated as the power domain transitions from active to off state (or to OSWR state for the
> USBTLL), whereas the restore mechanism is initiated as the power domain transitions from off to active
> power state.

Can you try with the flag enabled?

> 
> Am I missing something?
> 
>>
>> But that alone is not enough for USB host to work. We need to make sure
>> we have covered all the erratas. There are a number of them which are
>> not covered yet in mainline.
> 
> Is there a list somewhere?
> 

They should be mentioned in the Silicon Errata.

http://www.ti.com/product/omap3530

regards,
-roger
