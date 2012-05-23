From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Wed, 23 May 2012 12:09:30 +0530
Message-ID: <4FBC8622.3020308@ti.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com> <1334752782-28804-3-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com> <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com> <4FB4CD45.4050807@ti.com> <CAORVsuWgn5Zuf9T1eVBjJJhTGL5jrY=hirTaZp8E2HprzbvHng@mail.gmail.com> <CAMQu2gwBYUmBLV+wByVxto_ETu6-YjHycGWnhVn-Tb9pJUngDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:54652 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892Ab2EWGjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 May 2012 02:39:39 -0400
Received: by obfk16 with SMTP id k16so13714917obf.2
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 23:39:38 -0700 (PDT)
In-Reply-To: <CAMQu2gwBYUmBLV+wByVxto_ETu6-YjHycGWnhVn-Tb9pJUngDw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean,

On Monday 21 May 2012 07:55 PM, Shilimkar, Santosh wrote:
> Jean,
> 
> On Mon, May 21, 2012 at 7:23 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>> Hi Santosh,
>>
>> On Thu, May 17, 2012 at 12:04 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:

[...]

>> What do you think?
>>
> I like the idea as mentioned. I just think the series should already
> take care of memory state, logic state and quirk flags to see how
> it looks overall. Will have one more fresh look at the series but if
> you have subsequent WIP patches which can handle the other
> parameters, please send that link.
> 
I have scanned the series again. Somehow I still find myself
not convinced with the approach. I found having PD OSWR
CSWR state is the only change from this series helps to
some extent. But if you look from PRCM point of view,
they are already two distinct power domain states. Only
bad part from programming perspective, is, it's needs
to take care of additional bit to set and get PD state.

If we actually support 'PWRDM_POWER_OSWRET" and
'PWRDM_POWER_CSWRET" as valid state then we can do
everything without the functional power state series.
I mean we can use 'omap_set_pwrdm_state()' as a single
API for programming the PD, instead of duplicating
these all over the place.

OSWR by definition can be customised per power
domain based on various supported logic and
memory states.With this series, OSWR definition
also become static and if that is agreed then
we should cab just make that as a state like
ON/OFF/INACTIVE.

But I don't want to object this series if
Paul is convinced and agrees with the approach.
My view may be bit narrow but I am not convinced
with the approach.

Btw, ther are some real differences in PD INACTIVE state
in OMAP3 and OMAP4+ devices. I had some discussion with
Paul before on it. It needs to be clubbed with
voltagedomain layer to properly represent. Some
discussion was on the list [1] and some of that
was off list with hardware designers. Relevant
thread is here [1]

Regards
Santosh

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041133.html
