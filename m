From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD
 init
Date: Mon, 30 May 2011 10:32:50 +0200
Message-ID: <4DE35632.7060501@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>	<1306375016-707-4-git-send-email-nm@ti.com>	<87oc2p82q0.fsf@ti.com>	<4DDF4E4D.6060008@ti.com>	<87oc2ox7bm.fsf@ti.com> <BANLkTi==jZV13S1tzuRbWuoJytCZCBeWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1E3Icy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 04:32:54 -0400
In-Reply-To: <BANLkTi==jZV13S1tzuRbWuoJytCZCBeWQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On 5/29/2011 11:04 PM, Steve Calfee wrote:
> On Fri, May 27, 2011 at 12:38 PM, Kevin Hilman<khilman@ti.com>  wrote:
>> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>>
>> [...]
>>
>>> In general we do not want to reset nor idle an IP that was potentially
>>> already properly configured by bootloader or early Linux boot code.
>>
>> Actually, the opposite is true.
>>
>> The kernel should not make any assumptions about what the bootloader has
>> or has not done.  We need to have a kernel that can boot from any
>> bootloader (or none, like using kexec) and be able to start from a known
>> hardware state.
>>
> YES. Bootloaders should only do what is necessary (set clocks, enable
> memories etc) to load the next stage. Pushing stuff that should be in
> the kernel into the bootloader (like iniiting gpios and other things)
> bloats it and makes a developer deal with two entirely different
> source trees (kernel and booterx) to enable a new feature or to fix
> bugs.
>
> Uboot tends to lag the kernel in capabilities too, probably because
> fewer developers or something. For instance Beagleboard xm uboot
> cannot access the ethernet because it is usb based, and uboot cannot
> access its own environment in flash - because it is running from a new
> microsd based flash system. U-boot will eventually catch up with
> these, but by then other new hardware will be available.
>
> Does anyone know if 2.6.39 has kexec working again for the kernel? NFS
> boot is a dream development environment but with both u-boot and kexec
> not working with nfs, it is slightly more work and less automated.

I apologize for the confusing message in my answer.

The default behavior of the hwmod fmwk is to reset every IPs in order to 
ensure a stable and known state. The HWMOD flags should only be used in 
case of broken reset in an IP. That's why hacking the GPIO flag in that 
case is wrong.

That being said, you cannot prevent a board manufacturer to do some 
hacks in its bootloader, because it is require for proper voltage like 
here or because he wants to enable a splash screen and do not want to 
have ugly artifact on the screen due to asynchronous reset of the DSS.

In that case, it might be desirable to allow the board file to prevent 
such blind reset at boot time. Hence the need for a board level 
mechanism to change that default behavior.

Bootloader sucks, but you cannot prevent people to use them:-(

In an ideal world, the bootloader will not do anything, and everything 
will be perfectly handled by the kernel...

Benoit
