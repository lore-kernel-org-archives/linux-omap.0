From: H. Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH 0/3] ASoC: omap: Fix and add pm_qos
	configuration
Date: Wed, 14 Nov 2018 13:45:06 +0100
Message-ID: <2C9D3C26-75A9-4736-BC68-5954728083DB@goldelico.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114110623.30932-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Hi Peter,

> Am 14.11.2018 um 12:06 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
> 
> Hi,
> 
> The defconfig for OMAP2+ now have the CPU_IDLE enabled which can cause audio
> artifacts because we try to enter too low power state from where the wakeup
> takes longer than the FIFO can tolerate on the dai side.
> 
> While adding pm_qos to McPDM and DMIC I have noticed that the McBSP calculation
> was not correct as we need usec for the latency value.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
> ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
> ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with
>  CPU_IDLE
> ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
> 
> sound/soc/omap/omap-dmic.c  |  9 ++++++++
> sound/soc/omap/omap-mcbsp.c |  6 +++---
> sound/soc/omap/omap-mcpdm.c | 43 ++++++++++++++++++++++++++++++++++++-
> 3 files changed, 54 insertions(+), 4 deletions(-)

I will test asap.

BR and thanks,
Nikolaus
