From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
Date: Tue, 21 Feb 2017 14:27:02 +0530
Message-ID: <5c0967c9-cd60-372e-9a06-5c83fb880425@ti.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
 <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
 <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Dinh Nguyen <dinguyen@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 20 February 2017 02:10 PM, Geert Uytterhoeven wrote:
> Hi Sekhar,
> 
> On Mon, Feb 20, 2017 at 9:30 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
>>> As DaVinci uses the standard suspend_valid_only_mem() for its
>>> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
>>> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Looks good to me. Whats the plan for applying the series. Do you want
>> the individual machine maintainers to apply their parts. Or some other?
> 
> I think the individual machine maintainers is the simplest.

Patch 1/3 applied to branch v4.12/soc of my tree.

Thanks,
Sekhar
