From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
Date: Fri, 17 Dec 2010 21:38:20 -0800
Message-ID: <AANLkTinco-HzV-LY2F+Gguo1bsT8DkLmNHTZerPrvwDL@mail.gmail.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
 <AANLkTim_8wSpmY3fxjHGyczzCGk2Qe8Jmo9k9-ET6eSq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <AANLkTim_8wSpmY3fxjHGyczzCGk2Qe8Jmo9k9-ET6eSq@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 17, 2010 at 9:29 PM, Cory Maccarrone <darkstar6262@gmail.co=
m> wrote:
> On Fri, Dec 17, 2010 at 8:29 PM, Cory Maccarrone <darkstar6262@gmail.=
com> wrote:
>> On Fri, Dec 17, 2010 at 2:32 PM, Janusz Krzysztofik
>> <jkrzyszt@tis.icnet.pl> wrote:
>>> Most keypad drivers make use of the <linux/input/matrix_keypad.h>
>>> defined macros, structures and inline functions.
>>>
>>> Convert omap-keypad driver to use those as well, as suggested by a
>>> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
>>>
>>> Created against linux-2.6.37-rc5.
>>> Tested on Amstrad Delta.
>>> Compile tested with omap1_defconfig and omap2plus_defconfig shrinke=
d to
>>> board-h4.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>> ---
>>
>> Works perfectly on the herald, and no more warning message. =C2=A0Go=
od work!
>>
>> Tested-by: Cory Maccarrone <darkstar6262@gmail.com>
>>
>> - Cory
>>
>
> Hmm, I may have spoken too soon. =C2=A0This works perfectly on the la=
test
> Torvalds master branch, but does not seem to work applied to
> linux-omap/master. =C2=A0There, all my keys report the same KEY_RECOR=
D
> event.
>
> Probably not a problem in this patch, I think -- will try and track i=
t
> down. =C2=A0Out of curiosity, which branch did you test it on?
>
> - Cory
>

OK, looks like it definitely isn't this patch, something else on
linux-omap/master broke it.  I'll bisect and see if I can figure it
out.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
