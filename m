From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Linux-fbdev-devel] [APPLIED] [PATCH] omapfb: Reorder	Register_framebuffer
 call
Date: Fri, 25 Sep 2009 12:13:12 +0200
Message-ID: <4ABC97B8.80206@gmx.de>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>	<notify-1253583118@atomide.com>	<4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>	<20090922162853.GC14890@atomide.com>	<A24693684029E5489D1D202277BE89444B781B4E@dlee02.ent.ti.com> <4de7f8a60909231003w7bb9fdb9p7cf6fa0b2bc7e3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbZIYKNc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Sep 2009 06:13:32 -0400
In-Reply-To: <4de7f8a60909231003w7bb9fdb9p7cf6fa0b2bc7e3c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Blunck <jblunck@infradead.org>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Jan Blunck schrieb:
> On Tue, Sep 22, 2009 at 6:57 PM, Aguirre Rodriguez, Sergio Alberto
> <saaguirre@ti.com> wrote:
>> From: Tony Lindgren [tony@atomide.com]
>> Sent: Tuesday, September 22, 2009 11:28 AM
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
>> Hmm, ok. I guess i'll rework this patch considering that..
>>
>> I ran some framebuffer tests with this patch applied, and they worked fine for me.
>>
>> The only thing is that i didn't saw Tux on bootup...
>>
>> Actually, nobody ever gave this kind of feedback, which was the initial idea.
>>
> 
> Sorry, I didn't look into it earlier.
> 
> BTW, I actually wonder if it's really necessary to initialize the
> mutex in register_framebuffer() or why it couldn't be done during
> allocation.

This small discussion between Linus and Krzysztof might explain it:
http://marc.info/?l=linux-kernel&m=124703449332064&w=2
or to summarize:
It is done the way it is done to keep drivers working that use 
statically declared fb_info.

Although I agree, that it would be cleaner the other way around.


Regards,

Florian Tobias Schandinat
