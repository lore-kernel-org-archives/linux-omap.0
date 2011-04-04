From: Peter Barada <peter.barada@logicpd.com>
Subject: Re: Question regarding suspend/resume
Date: Mon, 04 Apr 2011 10:40:01 -0400
Message-ID: <4D99D841.9040501@logicpd.com>
References: <4D7FBD31.6050806@gmail.com> <87wrk0gn41.fsf@ti.com>	<4D94E148.8060905@gmail.com> <8739m3auex.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:55275
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754533Ab1DDOjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:39:53 -0400
In-Reply-To: <8739m3auex.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Peter Barada <peter.barada@gmail.com>, Linux OMAP list <linux-omap@vger.kernel.org>

On 03/31/2011 04:48 PM, Kevin Hilman wrote:
> Hi Peter,
>
> Peter Barada <peter.barada@gmail.com> writes:
>
> [...]
>
>> Thanks for helping me to understand things.
>>
>> The kernel I'm using is TI's OMAPPSP_03.00.01.06 2.6.32 kernel [1]
>> with their u-boot [2] and x-loader[3], modified to run on Logic's
>> DM3730 board(s) (as we use the Micron mt29c4g48mazapakq-5 POP).  
> I'm afraid somone who supports that older TI kernel will have to help
> you out.
>
> If you can reproduce on a current kernel, I'd be glad to help but I'm
> currently not able (well, not willing is more accurate) to try and
> figure out what's going on based on an older kernel with who knows how
> many out-of-tree patches/hacks piled on.
I've tried with a newer kernel and see different results:
http://dchs.spinics.net/lists/linux-omap/msg49235.html

> What I can say based on the register dump you shared is that there is no
> obvious driver issue going on where a clock was left on by a driver.
>
> More than likely what is going on is that the booloader is using a
> device (e.g. USB, MMC) but is leaving it in a state such that that IP
> block cannot idle, so the CORE powerdomain then does not fully idle.
> In older kernels like this one, the linux drivers did not fully reset
> the hardware so bootloaders could cause problems like this (the u-boot
> on beagle has had several problems like this.)
How can I determine if an IP block is not idled?  Any suggestion where to add code into the suspend patch to do such a check?
> As a first whack at things, I would focus on USB OTG and MMC, as I've
> seen problem with both on other platforms, like Beagle.  You need to
> ensure that both the these modules are fully reset either by the
> bootloader when it's done using them, or by the kernel in the early boot
> process.  Current kernels now do the latter.
Hmm, where in the current kernel is this done, device driver probe functions or common platform init code?
> Sorry I can't be of more help,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Peter Barada
peter.barada@logicpd.com

