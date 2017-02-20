From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] ARM: davinci: PM: Drop useless check for PM_SUSPEND_STANDBY
Date: Mon, 20 Feb 2017 09:40:44 +0100
Message-ID: <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be> <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Dinh Nguyen <dinguyen@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Sekhar,

On Mon, Feb 20, 2017 at 9:30 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
>> As DaVinci uses the standard suspend_valid_only_mem() for its
>> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
>> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Looks good to me. Whats the plan for applying the series. Do you want
> the individual machine maintainers to apply their parts. Or some other?

I think the individual machine maintainers is the simplest.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
