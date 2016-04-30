From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 0/2] Fix ir-rx51 by using PWM pdata
Date: Sat, 30 Apr 2016 20:52:11 +0300
Message-ID: <5724F0CB.6060807@gmail.com>
References: <1461714709-10455-1-git-send-email-tony@atomide.com>
 <57227E63.4040907@gmail.com> <20160428212748.GI5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20160428212748.GI5995@atomide.com>
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 29.04.2016 00:27, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160428 14:21]:
>>
>> I didn't test legacy boot, as I don't really see any value of doing it now
>> the end of the legacy boot is near, the driver does not function correctly,
>> however the patchset at least allows for the driver to be build and we have
>> something to improve on. And I am going to send a patch that fixes the
>> problem with omap_dm_timer_request_specific(). So, for both patches, you may
>> add:
>>
>> Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>
> OK thanks.
>
> Mauro, do the driver changes look OK to you?
>
> If so, I could queue the driver too for v4.7 because of the
> dependency with your ack. Or I can provide you an immutable
> branch with just the pdata changes against v4.6-rc1 if you
> prefer that.
>

In the meanwhile I was able to make the driver functional (on top of the 
$subject series) - for that purpose I had to fix dmtimer.c - it turns 
out that PM runtime get()/put() is called in almost every function 
exported by dmtimer, which in turn slows down IR transmission to 4-5s 
instead of 0.5s. I also replaced GPT9 dmtimer with PWM framework API 
(pwm-omap-dmtimer needs a patch) and implemented some DT support.

Now, how shall I proceed with those - wait for the $subject series to be 
accepted or post the patches now?

Tony, I was unable to find the tree on kernel.org your patches are in. 
Which tree to use to base my patches on?

Thanks,
Ivo
