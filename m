From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 RESEND 0/4] clk: clk: Add functions to save/restore
 clock context en-masse
Date: Wed, 3 Oct 2018 15:38:31 +0300
Message-ID: <c46b0b42-2325-7baf-2e97-5e45b26aaea4@ti.com>
References: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: d-gerlach@ti.com, russ.dill@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

Queuing the three clock patches for 4.20 (assuming these can still fit 
in), the pm33xx related patch should be picked up by Tony.

-Tero

On 04/09/18 09:49, Keerthy wrote:
> Deep enough power saving mode can result into losing context of the clock
> registers also, and they need to be restored once coming back from the power
> saving mode. Hence add functions to save/restore clock context.
> 
> Tested for DS0 on am437x-gp-evm
> 
> Based on top of linux-next
> 
> Resend Series:
> 
>    * Rebased on top of Linux 4.19-rc2
>    * Added Tony's Ack.
> 
> Changes in v2:
> 
>          * Renamed clk_dflt_restore to clk_gate_restore_context
> 
> Changes in v3: Corrected the e-mail address of linux-omap list
> 
> Keerthy (2):
>    clk: clk: Add clk_gate_restore_context function
>    ti: pm33xx: Save/restore clk context based on enable_off_mode setting
> 
> Russ Dill (2):
>    clk: clk: Add functions to save/restore clock context en-masse
>    clk: ti: Add functions to save/restore clk context
> 
>   arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
>   drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
>   drivers/clk/ti/clock.h               |   2 +
>   drivers/clk/ti/divider.c             |  36 ++++++++++
>   drivers/clk/ti/dpll.c                |   6 ++
>   drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
>   drivers/clk/ti/gate.c                |   3 +
>   drivers/clk/ti/mux.c                 |  29 ++++++++
>   drivers/soc/ti/pm33xx.c              |  13 ++++
>   include/linux/clk-provider.h         |   9 +++
>   include/linux/clk.h                  |  25 +++++++
>   include/linux/clk/ti.h               |   6 ++
>   include/linux/platform_data/pm33xx.h |   1 +
>   13 files changed, 362 insertions(+)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
