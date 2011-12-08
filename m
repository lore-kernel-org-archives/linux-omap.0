From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 14:14:19 -0600
Message-ID: <CAB-zwWgy_wgwypVPfiAHfEemSwHvzED0YjiMStw3M=UpQqq3Kg@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s0OvrrWnYJzowkMUT7-jHKYS=LZUty=e1d9gM=OZT-0Ow@mail.gmail.com>
	<CAB-zwWiNkD=jinUgvdd6w8-2BCYTB+TiPBJij+LgY13gO=NQoQ@mail.gmail.com>
	<CAMP44s0DGZVD34u=5DaFPGHwVaQ5O2s+U0W2w8MnNMUbr6Jong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46237 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834Ab1LHUOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 15:14:21 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so3172264wgb.13
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 12:14:19 -0800 (PST)
In-Reply-To: <CAMP44s0DGZVD34u=5DaFPGHwVaQ5O2s+U0W2w8MnNMUbr6Jong@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 1:50 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 8, 2011 at 9:10 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
>> On Wed, Dec 7, 2011 at 4:11 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>>>> Given that dm timer framework doesn't support request of clocks
>>>> by soft | hard irqs because some recent changes, tidspbridge needs
>>>> to request its clocks on init and enable/disable them on demand.
>>>>
>>>> This was first seen on 3.2-rc1.
>>>>
>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>
>>> This looks similar similar to this one:
>>> http://article.gmane.org/gmane.linux.ports.arm.omap/61816
>>>
>>> Are you sure this is what we want instead of that one?
>>
>> I believe your patch only takes care of gpt5 and gpt6, but not of the
>> other 2 that could be requested by the dsp, let's say gpt8 for avsync.
>
> I'm not really sure about that... Judging from the code, the only
> timers needed used to be initialized on bridge_brd_start based on the
> symbols of the baseimage. If you say that's not enough, then I guess
> that's fine (not really surprising that the old code missed that).

I meant the dsp by itself can generate that request. That is why it is
not explicitly seen in the code.

>> - Handles the other gpt that can be requested by the dsp.
>
> And I guess which clocks are going to be used is not discoverable somehow...

It is basically the pool of clocks of the dsp is formed by mcbsp, gpt,
wdt, ssi. The dsp can request any gpt from 5 to 8 according to the
binary you are running on the dsp side. That's the reason it is
somewhat hidden what clock the dsp needs.

>> - Uses start/stop according to future plans of making enable/disable static.
>
> Yeah, but that's easy to change s/enable/start/ s/disable/stop/

Agree

>> - Might be temporal if *dm_timer_request* functions are fixed and
>> there is an overall feeling that we can revert to use
>> request+start/stop+free on request.
>
> At which point we would end up with something similar to my patch :)

Yes, plus handling the other clocks that can be available to the dsp.

> Anyway, I guess there's not much problem in requesting extra clocks
> that we would not use.

AV playback does use gpt8, but for systems that doesn't use gpt8 it is
best to use the old approach of just request/free prior to dm timer
changes.

Regards,

Omar
