From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] dma: edma: Allow to disable eDMA IRQ during cyclic
 transfer
Date: Mon, 28 Jul 2014 17:04:21 +0530
Message-ID: <20140728113421.GA8181@intel.com>
References: <1405513761-23739-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405513761-23739-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, joelf@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, dmaengine@vger.kernel.org, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 16, 2014 at 03:29:19PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> After this series clients can ask to not receive notifications after each period.
> In this case we can disable the completion interrupt since the position reporting
> does not rely on it for cyclic mode.
> Patchset for ASoC part has been sent which allows users space to take adventage
> of SNDRV_PCM_INFO_NO_PERIOD_WAKEUP:
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-July/078993.html

Applied, thanks

Please use right subsystem name for patches, i have fixed that while
applying

-- 
~Vinod
