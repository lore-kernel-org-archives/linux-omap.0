From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] [media] ir-rx51: Fix build after multiarch changes
 broke it
Date: Thu, 28 Apr 2016 23:43:07 +0300
Message-ID: <572275DB.8090300@gmail.com>
References: <1461714709-10455-1-git-send-email-tony@atomide.com>
 <1461714709-10455-3-git-send-email-tony@atomide.com>
 <572266AF.9020601@gmail.com> <20160428202248.GG5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20160428202248.GG5995@atomide.com>
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=D0=A5=D0=B8,

On 28.04.2016 23:22, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160428 12:39]:
>> On 27.04.2016 02:51, Tony Lindgren wrote:
>>
>> omap_dm_timer_request_specific always fails with message "Please use
>> omap_dm_timer_request_by_cap/node()" with DT boot.
>>
>> I hacked the code to use omap_dm_timer_request_by_cap(OMAP_TIMER_HAS=
_PWM)
>> and it seems to use the correct timer (IR LED blinks, checked with t=
he
>> camera of Samsung S4 mini), but it doesn't actually control either o=
f the TV
>> sets here. The same SW(pierogi) controls them when device is booted =
to stock
>> kernel. However, this seems another problem not related to the patch=
=2E
>
> OK thanks for testing, I'll apply the pdata patch then.
>
> I assume you'll post a separate fix for the request_by_cap
> driver change?
>

Well, it was a hack, it just happens that the first matched timer is=20
GPT9, I think we should aim for a proper solution (request_by_node()).

Shall I prepare a patch that gets the timer from the DT?

Ivo
