From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
Date: Fri, 17 Dec 2010 21:29:12 -0800
Message-ID: <AANLkTim_8wSpmY3fxjHGyczzCGk2Qe8Jmo9k9-ET6eSq@mail.gmail.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63168 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0LRF3e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 00:29:34 -0500
In-Reply-To: <AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 17, 2010 at 8:29 PM, Cory Maccarrone <darkstar6262@gmail.co=
m> wrote:
> On Fri, Dec 17, 2010 at 2:32 PM, Janusz Krzysztofik
> <jkrzyszt@tis.icnet.pl> wrote:
>> Most keypad drivers make use of the <linux/input/matrix_keypad.h>
>> defined macros, structures and inline functions.
>>
>> Convert omap-keypad driver to use those as well, as suggested by a
>> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
>>
>> Created against linux-2.6.37-rc5.
>> Tested on Amstrad Delta.
>> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked=
 to
>> board-h4.
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>> ---
>
> Works perfectly on the herald, and no more warning message. =C2=A0Goo=
d work!
>
> Tested-by: Cory Maccarrone <darkstar6262@gmail.com>
>
> - Cory
>

Hmm, I may have spoken too soon.  This works perfectly on the latest
Torvalds master branch, but does not seem to work applied to
linux-omap/master.  There, all my keys report the same KEY_RECORD
event.

Probably not a problem in this patch, I think -- will try and track it
down.  Out of curiosity, which branch did you test it on?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
