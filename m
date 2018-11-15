From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 0/3] ASoC: omap: Fix and add pm_qos
	configuration
Date: Thu, 15 Nov 2018 13:26:03 +0100
Message-ID: <6128350C-8801-492F-9FE6-B07CCAF56925@goldelico.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
 <2C9D3C26-75A9-4736-BC68-5954728083DB@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2C9D3C26-75A9-4736-BC68-5954728083DB@goldelico.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pyra-handheld.com, Andreas Kemnade <andreas@kemnade.info>, linux-omap <linux-omap@vger.kernel.org>, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 14.11.2018 um 13:45 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Peter,
> 
>> Am 14.11.2018 um 12:06 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
>> 
>> Hi,
>> 
>> The defconfig for OMAP2+ now have the CPU_IDLE enabled which can cause audio
>> artifacts because we try to enter too low power state from where the wakeup
>> takes longer than the FIFO can tolerate on the dai side.
>> 
>> While adding pm_qos to McPDM and DMIC I have noticed that the McBSP calculation
>> was not correct as we need usec for the latency value.
>> 
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (3):
>> ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
>> ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with
>> CPU_IDLE
>> ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
>> 
>> sound/soc/omap/omap-dmic.c  |  9 ++++++++
>> sound/soc/omap/omap-mcbsp.c |  6 +++---
>> sound/soc/omap/omap-mcpdm.c | 43 ++++++++++++++++++++++++++++++++++++-
>> 3 files changed, 54 insertions(+), 4 deletions(-)
> 
> I will test asap.

I have now:

* v4.20-rc2
* plus your new patches
* plus letux-4.20-rc2 patches
* including our private AESS patch set (mostly inactive, because it fails to load firmware)
* CONFIG_CPU_IDLE=y

and it works. I can use aplay and play to get handsfree audio as with CONFIG_CPU_IDLE=n

Sometimes, there is a scratchy tenth of a second (in handsfree and headset),
but the basic rhythm does not get interrupted any more and the play command does
not get stuck.

I have played an mp3 of 4 minutes and the play process did succeed and didn't report
buffer underrun issues.

So your patches seem to fix the issue. At least the basic problems. This scratchy
thing needs further study, if it is a spurious thing on my Pyra protoype device.
Or if it is still there if we disable CPU_IDLE again (I haven't tried that yet).

BR and thanks for quick help,
Nikolaus
