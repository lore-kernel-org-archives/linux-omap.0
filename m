From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: tidspbridge issue with omap_dm_timer_free
Date: Sun, 14 Aug 2011 10:44:45 +0300
Message-ID: <CAMP44s2MpAE09sa-ow0k6qUjUwd-4+z-czzNaO7mv+fu0zipeA@mail.gmail.com>
References: <CAMP44s17O-g83Fte05=AmqBP24jqgLxiBHmO6+3fbtJjWV8Ufw@mail.gmail.com>
	<CAMP44s2Wou54d2UWkwebxO17=gaVoiXrB5Lk-q2g90x3ok8L7w@mail.gmail.com>
	<CAB-zwWhRxhdrtzNy6MK=xyj25J_1adWBELVi+X=32k76owuyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54496 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1HNHos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 03:44:48 -0400
Received: by bke11 with SMTP id 11so2431938bke.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 00:44:47 -0700 (PDT)
In-Reply-To: <CAB-zwWhRxhdrtzNy6MK=xyj25J_1adWBELVi+X=32k76owuyRw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

On Sat, Aug 13, 2011 at 8:20 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Wed, Aug 10, 2011 at 6:27 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, Aug 10, 2011 at 9:42 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> I am trying to use a more recent version of the tidspbridge code in
>>> the Nokia N9, but I'm stuck with this warning that is caused by using
>>> the dm timer framework.
>>
>> Actually, the problem only happens on the 'dspbridge' branch, which
>> has some unmerged patches. These patches introduce some new mutexes
>> that trigger this.
>
> The only lock introduced is a spin_lock_bh which makes sense to warn
> if the underlying functions have a mutex, but I couldn't find the
> clk_set_parent mutex which is causing this on the omap files.

Hmmm, that's true. It seems I also have this series:
http://thread.gmane.org/gmane.linux.ports.arm.omap/18509/focus=18508

That for some reason never made it anywhere. Perhaps it will?

>> My proposed solution is to request the dm timers at initialization
>> time, and just enable/disable them on wake/hibernate, which is a bit
>> similar to what was happening before, and probably more efficient and
>> proper.
>
> When I made these changes I wanted to avoid keeping an array with the
> clocks requested and nobody else being able to use them (even if that
> meant a conflict between two drivers trying to use the same clock, but
> other warnings could help to point to such cases). Also I wanted to
> maintain uniformity, not just requesting some clock, freeing them and
> then some others to be held and freed only on module removal.
>
> That said, I have no problem on changing to your approach if needed.

Yeah, but with the current approach it would be possible that
everything works fine, and then the DSP goes to hibernation, a module
is loaded that uses one dm timer, and then when the DSP wakes up, that
timer would fail, there isn't even a check for that. If I follow the
code correctly, when the DSP goes back to hibernation, there would be
a crash, as a NULL timer would be freed. I think that's too error
prone.

-- 
Felipe Contreras
