From: Angelo Arrifano <miknix@gmail.com>
Subject: Re: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
Date: Tue, 22 Sep 2009 18:46:44 +0100
Message-ID: <4AB90D84.7020204@gmail.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com> <notify-1253583118@atomide.com> <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com> <20090922162853.GC14890@atomide.com>,<4AB907A8.8040805@gmail.com> <A24693684029E5489D1D202277BE89444B781B50@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:32990 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbZIVRkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:40:42 -0400
Received: by ewy7 with SMTP id 7so634939ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 10:40:45 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B50@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Alistair Buxton <a.j.buxton@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre Rodriguez, Sergio Alberto wrote:
> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Angelo Arrifano [miknix@gmail.com]
> Sent: Tuesday, September 22, 2009 12:21 PM
>> To: Tony Lindgren
>> Cc: Alistair Buxton; linux-omap@vger.kernel.org
>> Subject: Re: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
>>
>> Tony Lindgren wrote:
>>> * Jan Blunck <jblunck@infradead.org> [090922 07:59]:
>>>> On Tue, Sep 22, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>>> This patch has been applied to the linux-omap
>>>>> by youw fwiendly patch wobot.
>>>>>
>>>>> Branch in linux-omap: omap-fixes
>>>>>
>>>>> Initial commit ID (Likely to change): 9aef1066fb5ca8506068eaab1c552ecca4c85475
>>>>>
>>>>> PatchWorks
>>>>> http://patchwork.kernel.org/patch/47089/
>>>>>
>>> Added back the original Cc's that were dropped from the linux-omap
>>> commit message.
>>>
>>>> Is it actually safe to do this? The framebuffer can be used directly
>>>> after it is registered. In this case it would mean it is used before
>>>> it is even fully initialized (set_fb_var(), set_fb_fix(), ... are
>>>> being called).
>>> Good point, dropping the patch.
>>>
>>> Also, let's let Tomi Valkeinen deal with queueing up the omap fb code.
>>> I can then merge Tomi's branck into linux-omap master branch as needed.
>>>
>>> Regards,
>>>
>>> Tony
>> Hello,
>>
>> This patch doesn't work for us at linwizard project (omap850). The
>> commit 537a1bf059fa312355696fa6db80726e655e7f17 makes the HTC Wizard
>> crash at boot due to usage of uninitialized mutex. Applying the referred
>> patch prevents the crash but the LCD screen goes black and doesn't show
>> any data.
> 
> Angelo,
> 
> 
> Some people gave his ACK, because it was booting. and also i kept it since some framebuffer tests in my 3430SDP passed (i.e. it was showing the intended data.)

Yeah, sorry for the late reply. I was going to add a test-by reply to
the patch but I didn't have much info to offer other than it doesn't
work for me. At the time USB was also not working so I really didn't
have a way to debug in case it was asked.

> 
> However, didn't show the Tux during bootup. Isn't the same case as you?
No tux, no text, just a black screen.

> 
> Anyways, Thanks for sharing your results... I'll rework this patch and resend once i'm done.

Thanks,
- Angelo
> 
> Regards,
> Sergio
>> - Angelo
