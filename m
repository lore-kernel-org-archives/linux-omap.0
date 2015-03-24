From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] clk: ti: OMAP3: McBSP clock fixes
Date: Tue, 24 Mar 2015 20:50:20 +0200
Message-ID: <5511B1EC.7080406@ti.com>
References: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@linaro.org, sboyd@codeaurora.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/16/2015 12:40 PM, Peter Ujfalusi wrote:
> Hi,
>
> This series will fix the following error during boot (both DT and legacy boot):
> [    0.307739] omap_hwmod: mcbsp2: _wait_target_ready failed: -16
> [    0.307769] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
>
> The clock definitions/aliases for McBSP ports were not correct.
>
> In case of DT boot we still have the following warning printed from hwmod:
> [    0.222900] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
> [    0.225311] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
>
> These are there because mcbsp is using two hwmods in the DT and hwmod prints
> out a warning for these. In legacy mode we also have 2 hwmods for McBSP2/3.
> One for the McBSP itself and the other for the sidetone block attached to them.
> I'll try to look into this one next.
>
> Since this series fixes the _wait_target_ready issue, can this be sent for 4.0?

I don't think this is a critical fix, the wait_target_ready issue has 
been around for ages. Queued for 4.1 though, thanks.

-Tero

>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>    clk: ti: clk-3xxx: Correct McBSP related DT clock definitions
>    clk: ti: clk-3xxx-legacy: Correct McBSP related clock aliases
>
>   drivers/clk/ti/clk-3xxx-legacy.c | 16 +++++++++-------
>   drivers/clk/ti/clk-3xxx.c        | 19 +++++++------------
>   2 files changed, 16 insertions(+), 19 deletions(-)
>
