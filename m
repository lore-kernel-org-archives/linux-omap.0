From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
Date: Wed, 17 Jun 2009 21:56:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D1897@dbde02.ent.ti.com>
References: <notify-1245247047@atomide.com>
 <87vdmuyhxc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38666 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbZFQQ02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 12:26:28 -0400
In-Reply-To: <87vdmuyhxc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>Sent: Wednesday, June 17, 2009 10:55 AM
>To: Tony Lindgren; Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
>
>Tony Lindgren <tony@atomide.com> writes:
>
>> This patch has been applied to the linux-omap
>> by youw fwiendly patch wobot.
>>
>> Branch in linux-omap: omap-fixes
>>
>> Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
>>
>> PatchWorks
>> http://patchwork.kernel.org/patch/29668/
>>
>> Git (Likely to change, and takes a while to get mirrored)
>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
>2.6.git;a=commit;h=f84eca35d44fd64cdde542f12d08eb04ca534954
>
>Sorry, I didn't get to this beforethe merge, but $SUBJECT for this
>patch is wrong and not terribly helpful.  It refers to the symptom, bu
>tnot the root cause.
>
>It should be something like:
>
>OMAP3: Zoom2: pass IRQ triggering flags for serial driver

Yes that should have been the subject and 
is put that way for the 8250 driver:
http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach

It's learning for next time.

>
>Kevin
>
>

