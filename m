From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/3] ASoC: omap: Fix and add pm_qos
	configuration
Date: Sun, 18 Nov 2018 19:04:59 +0200
Message-ID: <b08cb2ac-b02f-861d-7ff8-f91b2ca08fd8@bitmer.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
 <2C9D3C26-75A9-4736-BC68-5954728083DB@goldelico.com>
 <6128350C-8801-492F-9FE6-B07CCAF56925@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <6128350C-8801-492F-9FE6-B07CCAF56925@goldelico.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/15/18 2:26 PM, H. Nikolaus Schaller wrote:
>>> Peter Ujfalusi (3):
>>> ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
>>> ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with
>>> CPU_IDLE
>>> ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
>>>
>>> sound/soc/omap/omap-dmic.c  |  9 ++++++++
>>> sound/soc/omap/omap-mcbsp.c |  6 +++---
>>> sound/soc/omap/omap-mcpdm.c | 43 ++++++++++++++++++++++++++++++++++++-
>>> 3 files changed, 54 insertions(+), 4 deletions(-)
>>
>> I will test asap.
> 
> I have now:
> 
> * v4.20-rc2
> * plus your new patches
> * plus letux-4.20-rc2 patches
> * including our private AESS patch set (mostly inactive, because it fails to load firmware)
> * CONFIG_CPU_IDLE=y
> 
> and it works. I can use aplay and play to get handsfree audio as with CONFIG_CPU_IDLE=n
> 
> Sometimes, there is a scratchy tenth of a second (in handsfree and headset),
> but the basic rhythm does not get interrupted any more and the play command does
> not get stuck.
> 
> I have played an mp3 of 4 minutes and the play process did succeed and didn't report
> buffer underrun issues.
> 
> So your patches seem to fix the issue. At least the basic problems. This scratchy
> thing needs further study, if it is a spurious thing on my Pyra protoype device.
> Or if it is still there if we disable CPU_IDLE again (I haven't tried that yet).
> 
Peter: do you have some simple test case for N810 or N900? I tried to
play with a few different aplay --buffer-size and --period-size
combinations to see can I hit this. N810 most probably wasn't able to
hit deep enough idle as the display is on due there is no driver for it.
On N900 I have display blanked.

I have one educational question on 1/3 but no any show stoppers. For all
three:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
