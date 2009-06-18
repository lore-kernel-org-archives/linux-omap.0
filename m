From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading	issue
Date: Thu, 18 Jun 2009 19:02:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D1C45@dbde02.ent.ti.com>
References: <notify-1245247047@atomide.com>
 <87vdmuyhxc.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D1897@dbde02.ent.ti.com>
 <20090618052710.GB8482@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbZFRNcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 09:32:22 -0400
In-Reply-To: <20090618052710.GB8482@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Thursday, June 18, 2009 12:27 AM
>To: Pandita, Vikram
>Cc: Kevin Hilman; linux-omap@vger.kernel.org
>Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
>
>* Pandita, Vikram <vikram.pandita@ti.com> [090617 19:26]:
>>
>>
>> >-----Original Message-----
>> >From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >Sent: Wednesday, June 17, 2009 10:55 AM
>> >To: Tony Lindgren; Pandita, Vikram
>> >Cc: linux-omap@vger.kernel.org
>> >Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
>> >
>> >Tony Lindgren <tony@atomide.com> writes:
>> >
>> >> This patch has been applied to the linux-omap
>> >> by youw fwiendly patch wobot.
>> >>
>> >> Branch in linux-omap: omap-fixes
>> >>
>> >> Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
>> >>
>> >> PatchWorks
>> >> http://patchwork.kernel.org/patch/29668/
>> >>
>> >> Git (Likely to change, and takes a while to get mirrored)
>> >> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
>> >2.6.git;a=commit;h=f84eca35d44fd64cdde542f12d08eb04ca534954
>> >
>> >Sorry, I didn't get to this beforethe merge, but $SUBJECT for this
>> >patch is wrong and not terribly helpful.  It refers to the symptom, bu
>> >tnot the root cause.
>> >
>> >It should be something like:
>> >
>> >OMAP3: Zoom2: pass IRQ triggering flags for serial driver
>>
>> Yes that should have been the subject and
>> is put that way for the 8250 driver:
>> http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach
>>
>> It's learning for next time.
>
>Will revert. I guess we now need two 8250 patches upstream? One for the
>omap register define, and one for the interrupt flags?

Would be very helpful if you could host these 8250 patches on l-o till we get someone to respond to these. This is a critical dependency.


>
>Tony

