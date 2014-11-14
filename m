From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: N900 modem support in 3.18-rc1
Date: Fri, 14 Nov 2014 09:04:23 +0200
Message-ID: <5465A977.4030605@gmail.com>
References: <20141104205117.GA17606@amd> <20141106180335.GA21513@earth.universe> <20141106225005.GA14002@amd> <201411070001.46481@pali> <545C6F14.8050303@gmail.com> <20141113162420.GB8512@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141113162420.GB8512@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali Roh?r <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org



On 13.11.2014 18:24, Pavel Machek wrote:
> On Fri 2014-11-07 09:04:52, Ivaylo Dimitrov wrote:
>
> Sebastian is quiet, can we have the patch? :-).

Sure, why not :)

https://gitorious.org/linux-n900/freemangordons-linux-n900/commits/30e9a5c498a89cea4c29523f69e436bf0af3c631

commits 89ce13b, b81d80d, ec4d0dc, 91256e2 and 8022a6d - e29f558 (no 
idea why gitorious shows those mixed with SGX stuff, on my local tree it 
is contiguous patch series)

didn't test against the current upstream, but I see no reason why those 
should not apply, build and run.

>
>> About the pulseaudio stuff - we're still in process of REing it, so
>> far there are 2 out of 3 closed Nokia modules ready
>> (https://gitorious.org/pulseaudio-nokia), but the last one, which is
>> the one used for voice calls is still not ready and will take it a
>> while :).
>
> Ok, is there a way I could help? Pretty much everything else works with
> opensource drivers...
>

There is, though I am not sure you'll like it much - fire up IDA and 
join the party :P. Ping me on IRC for more details in case you're 
interested.

Regards,
Ivo
