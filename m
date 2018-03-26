From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Mon, 26 Mar 2018 10:50:17 +0200
Message-ID: <CACRpkdYpv2EZj6a0_KJN+BdSRT=HRCnh8PGDTqQkKpgX1mEm0g@mail.gmail.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
 <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com> <20180323142234.GH5799@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323142234.GH5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Lechner <david@lechnology.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 23, 2018 at 3:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [180323 03:02]:
>> On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:
>>
>> > This fixes pcs_request_gpio() in the pinctrl-single driver when
>> > bits_per_mux != 0. It appears this was overlooked when the multiple
>> > pins per register feature was added.
>> >
>> > Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
>> > Signed-off-by: David Lechner <david@lechnology.com>
>> > ---
>> >
>> > v2 changes:
>> > - don't wrap Fixes: line in commit message since it is a special machine-
>> >   readable line.
>>
>> Tony/Haojian: are you OK with this change?
>
> No objections from me, would be good if Haojian could
> test it with his test cases though.

I applied it for v4.17 recording this as an ACK :)

If there are problems I bet we will notice in the -rc phase.

Yours,
Linus Walleij
