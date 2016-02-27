From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle
 calculation
Date: Fri, 26 Feb 2016 20:31:00 -0500
Message-ID: <20160226203100.303fe192.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jan 2016 23:26:50 -0500
"David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:

> From: David Rivshin <drivshin@allworx.com>
> 
> When using a short PWM period (approaching the min of 2/clk_rate),
> pwm-omap-dmtimer does not produce accurate results. In the worst case a
> requested period of 2/clk_rate would result in a real period of 4/clk_rate
> instead. This is a series includes a fix for that problem, as well as
> other related improvements, and is based on the current linux-pwm/for-next
> tip.
> 
> I have tested on a Sitara AM335x platform, using a scope to verify the
> output with a variety of periods and duty cycles. This includes a PWM
> rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test with,
> although appropriate sections in the the reference manuals appear
> substantially the same, so I believe the changes are equally correct
> there.
> 
> Note that the OMAP4 TRMs do effectively state that the maximum PWM
> rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> as reliable as I observed with Sitara. Although I suspect that it's
> the same module and will also work, at least under some circumstances.
> If anyone with OMAP4 hardware and a scope is so inclined, I would be
> curious to know the results.
> 
> David Rivshin (4):
>   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
>   pwm: omap-dmtimer: add sanity checking for load and match values
>   pwm: omap-dmtimer: round load and match values rather than truncate
>   pwm: omap-dmtimer: add dev_dbg() message for effective period and duty
>     cycle
> 
>  drivers/pwm/pwm-omap-dmtimer.c | 71 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 16 deletions(-)
> 

Hi Thierry,

Gentle ping. It does not look like you've taken this series, and I 
wanted to make sure you're not waiting on something from me. It would 
be nice to get at least the first patch into 4.5, if possible.

Thanks!
