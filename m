From: Brian Murphy <brian.murphy@cobham.com>
Subject: Re: [Bug] am33xx: Basic suspend resume support: Doesn't resume
Date: Fri, 6 Dec 2013 11:16:48 +0100
Message-ID: <52A1A410.10100@cobham.com>
References: <1386250976.3880.91.camel@mars> <1386287031.3749.2.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og108.obsmtp.com ([64.18.2.169]:52098 "EHLO
	exprod7og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3LFKQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 05:16:51 -0500
In-Reply-To: <1386287031.3749.2.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-omap@vger.kernel.org

On 12/06/2013 12:43 AM, Christoph Fritz wrote:
> On Thu, 2013-12-05 at 14:42 +0100, Christoph Fritz wrote:
>> Hi,
>>
>>   I'm having here a custom am335x board with DDR3 equipped trying to
>> setup suspend/resume support. I have tested this with the ancient
>> TI-PSP-3.2 Kernel and current 3.13-rc plus some pm patches.
>>
>> Problem: After suspending the device, it doesn't resume (freeze):
>>
>> echo "mem" > /sys/power/state
>> [  103.020845] PM: Syncing filesystems ... done.
>> [  103.055549] Freezing user space processes ... (elapsed 0.003 seconds) done.
>> [  103.066696] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>> [  103.077506] PM: Sending message for entering DeepSleep mode
>> [  103.099896] PM: suspend of devices complete after 11.951 msecs
>> [  103.110894] PM: late suspend of devices complete after 4.659 msecs
>> [  103.122599] PM: noirq suspend of devices complete after 5.032 msecs
>>
>> As a wakeup source I'm currently using gpio0_12.
>>
>> Triggering the reset button (am335x-pin: WARMRSTn) in suspend-mode has
>> no effect, which is fine. But after changing the signal on the wakeup
>> source (here gpio0_12), triggering a reset works fine again.
>>
>> So it seems to me that somewhere in the wakeup-process is a bug.
>>
>> Could this be related to DDR3? Apart from that, this custom board here
>> is pretty similar to the ti-evm board wich works fine.
>>
>> In oder to test, I've shrunken the kernel to minimal driver support to
>> sort out as much as possible segfaults in resume functions.
>>
>> With a view to be able to debug this further, I just ordered an openocd
>> jtag adapter.
>>
>> Any comments, ideas, tips, ..?
> Update: It has definitely something to do with DDR3. I'll investigate
> this further. By the way, is there a TI-Board with DDR3 and working
> suspend-resume?
>
I don't think so. I would like to get DDR3 (beaglebone black) and our 
custom board with
mDDR working. Any chance of you sharing what you have of patches 
somewhere so there
will be two working on a common base? (me and you)

/Brian
