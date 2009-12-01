From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
Date: Tue, 01 Dec 2009 09:57:20 +0200
Message-ID: <4B14CC60.9030906@compulab.co.il>
References: <cover.1259481545.git.mike@compulab.co.il> <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il> <20091130211255.GZ4348@atomide.com> <f870da180911301358t239b1820ia7cdecf932d579d1@mail.gmail.com> <20091130231056.GB4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:46130 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbZLAH5T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 02:57:19 -0500
In-Reply-To: <20091130231056.GB4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, linux-omap@vger.kernel.org



Tony Lindgren wrote:
> * Mike Rapoport <mike.rapoport@gmail.com> [091130 13:57]:
>> On Mon, Nov 30, 2009 at 11:12 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Mike Rapoport <mike@compulab.co.il> [091129 00:10]:
>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>> ---
>>>>  arch/arm/mach-omap2/mux.h |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>>>> index e09c5d2..02a1b53 100644
>>>> --- a/arch/arm/mach-omap2/mux.h
>>>> +++ b/arch/arm/mach-omap2/mux.h
>>>> @@ -37,6 +37,8 @@
>>>>
>>>>  /* Active pin states */
>>>>  #define OMAP_PIN_OUTPUT                      0
>>>> +#define OMAP_PIN_OUTPUT_PULLUP               (OMAP_PULL_ENA | OMAP_PULL_UP)
>>>> +#define OMAP_PIN_OUTPUT_PULLDOWN     OMAP_PULL_ENA
>>>>  #define OMAP_PIN_INPUT                       OMAP_INPUT_EN
>>>>  #define OMAP_PIN_INPUT_PULLUP                (OMAP_PULL_ENA | OMAP_INPUT_EN \
>>>>                                               | OMAP_PULL_UP)
>>> Hmm, isn't this same as configuring as GPIO with up or
>>> down value?
>>>
>>> Or is there's some need doing it with mux only? Like
>>> power savings?
>> This is intended for dedicated pins rather than GPIO. Actually, I've
>> met only one till now, the HSUSB0_STP.
> 
> Hmm, are you sure you need the OMAP_PIN_OUTPUT_PULLUP for HSUSB0_STP?
> 
> AFAIK, it's not needed for other boards. I believe the STP should be
> down until the MUSB signals STP and pulls it up briefly. Might be
> worth checking.

Well, quick grep on HSUSB0_STP in U-Boot shows that all omap3 boards have
MUX_VAL(CP(HSUSB0_STP),         (IDIS | PTU | EN  | M0)) /*HSUSB0_STP*/
i.e pin is OUTPUT_PULLUP. I'll try to check if canceling the pull-up does not
affect mUSB functionality.

>> If you define most of the mux configuration in the kernel you
>> eventually run into very long lines in the omap_board_mux array. So,
>> shortening at least some of them seems good idea to me.
> 
> Yeah nothing wrong with that, I'm just thinking back to when we added
> these mux defines originally. It seemed like the the combination of
> out and pull should be needed, and pull would only be needed for inputs.
> 
>> Take a look at my second patch ([1]) for example of what I mean :)
>>
>> [1] http://en.wikipedia.org/wiki/Wikipedia:Tools/Editing_tools
> 
> I guess this is a wrong link here to the editing tool. Our mux
> code is bloated, but should not be _that_ bloated! :)

Oops :) This is the correct one:
http://thread.gmane.org/gmane.linux.ports.arm.omap/27341
Klipper screwed me entirely :)

> Eh, let's hope we don't need to implement kernel based wiki and
> editing tools for the muxing :)


> Regards,
> 
> Tony
> 

-- 
Sincerely yours,
Mike.

