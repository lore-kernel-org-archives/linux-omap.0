From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 Overo: Crash on boot with Linus' master
Date: Mon, 20 Aug 2012 14:26:34 +0530
Message-ID: <CAMQu2gyvdnW6LOGXYXZjsEHSx=K8jyC_JSwBbe-9FckYkv0O6g@mail.gmail.com>
References: <1343903452.2686.15.camel@deskari> <1344249504.12136.3.camel@deskari>
 <1345450118.2684.3.camel@deskari> <CAMQu2gwFSNFy8oKpnAWiey_bUvkRXOT_x=Ej=KYA+dLN-Q6S9Q@mail.gmail.com>
 <1345452870.2684.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40517 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753821Ab2HTI44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 04:56:56 -0400
Received: by iaeh11 with SMTP id h11so2531323iae.9
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 01:56:55 -0700 (PDT)
In-Reply-To: <1345452870.2684.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, tarun.kanti@ti.com, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, Aug 20, 2012 at 2:24 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On Mon, 2012-08-20 at 13:58 +0530, Shilimkar, Santosh wrote:
>> Tomi,
>>
>> On Mon, Aug 20, 2012 at 1:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > Hi,
>> >
>> > Anyone ideas what could I do to debug this further? The problem exists
>> > on v3.6-rc2.
>> >
>> Can you try merging [1] {[GIT PULL] arm-soc: bug fixes for v3.6-rc3}
>> and see if it helps.
>>
>> Regards
>> Santosh
>>
>> [1] https://lkml.org/lkml/2012/8/20/120
>
> Merging that branch seems to fix the issue. Good to know, thanks!
>
Cool !!
Thanks for confirming it.

Regards
Santosh
