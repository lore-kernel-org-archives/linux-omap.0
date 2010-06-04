From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 4/7] omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure
Date: Fri, 04 Jun 2010 08:25:10 -0700
Message-ID: <87fx12q0q1.fsf@deeprootsystems.com>
References: <1274186139-23960-1-git-send-email-leslyam@ti.com>
	<87r5koui2k.fsf@deeprootsystems.com>
	<007601cb03bb$573cef50$e08818ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36085 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0FDPZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 11:25:14 -0400
Received: by pwj5 with SMTP id 5so41555pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Jun 2010 08:25:13 -0700 (PDT)
In-Reply-To: <007601cb03bb$573cef50$e08818ac@apr.dhcp.ti.com> (Lesly Arackal Manuel's message of "Fri\, 4 Jun 2010 13\:25\:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly Arackal Manuel <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

"Lesly Arackal Manuel" <leslyam@ti.com> writes:

> Hi Kevin,
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Thursday, June 03, 2010 11:15 PM
>> To: Lesly A M
>> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
>> Samuel Ortiz
>> Subject: Re: [PATCH v6 4/7] omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_
>> in VC param structure
>> 
>> Lesly A M <leslyam@ti.com> writes:
>> 
>> > Rename vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure.
>> 
>> That answers "what?", but not "why?"
>> 
>> Yes, I know the answer right now, but I forget things often.
>> 
>> Please help ease the pain of my forgetfullness by writing a
>> descriptive changelog so when I or anyone else looks at this in the
>> git history, they will be able to understand.
>> 
>> Kevin
>
> Actually there is no VDD0, its VDD1 & VDD2. So the renaming is done just to
> avoid the confusion.

Yes.  As I said above, I do know why.  I just want it to be in the
changelog so when I forget, it will be easy for me to remember why.

*In the changelog*, you should be stating that you are changing the
names to match the hardware documentation or something along those
lines.

Kevin
