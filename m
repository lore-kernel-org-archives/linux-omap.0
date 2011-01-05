From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Wed, 05 Jan 2011 08:54:48 -0800
Message-ID: <87oc7v1eav.fsf@ti.com>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<87aajg7dzu.fsf@ti.com> <1294181154.18162.39.camel@localhost>
	<20110104231721.GO7771@atomide.com>
	<AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40460 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab1AEQy5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 11:54:57 -0500
Received: by pxi16 with SMTP id 16so3101231pxi.32
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 08:54:54 -0800 (PST)
In-Reply-To: <AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
	(Charulatha Varadarajan's message of "Wed, 5 Jan 2011 15:52:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Charu,

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Wed, Jan 5, 2011 at 04:47, Tony Lindgren <tony@atomide.com> wrote:
>> * Kevin Hilman <khilman@ti.com> [110104 14:45]:
>>> On Tue, 2011-01-04 at 09:52 -0800, Kevin Hilman wrote:
>>> > Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
>>> >
>>> > > In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
>>> > > updating reg and l values. However, at the end of the function =
we
>>> > > perform a write:
>>> > >
>>> > > =C2=A0 __raw_writel(l, reg);
>>> > >
>>> > > So on OMAP2+ we end up writing 0 to the bank->base which is not
>>> > > correct (typically this points to GPIO_REVISION register).
>>> > >
>>> > > Fix this by returning immediately after call to
>>> > > set_24xx_gpio_triggering().
>>> > >
>>> > > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com=
>
>>> >
>>> > Acked-by: Kevin Hilman <khilman@ti.com>
>>> >
>>> > Tony, this should be added to omap-for-linus as it fixes a proble=
m in
>>> > the recently merged GPIO omap_device/hwmod conversion.
>
> One clarification - This problem should be existing since the followi=
ng commit
> 92105bb70634abacc08bbe12bf6f888fbd7dad38
> which was introduced on Sep 7, 2005
>
> FYI, this part of the code remained untouched during GPIO omap_device=
/hwmod
> conversion.
>

OK, thanks for the clarification.

I had assumed it was recent changes since the patch didn't apply
cleanly, but am glad to be wrong. :)

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
