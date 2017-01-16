From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Mon, 16 Jan 2017 09:17:44 -0800
Message-ID: <20170116171743.GB7403@atomide.com>
References: <20170113035432.6723-1-matt@ranostay.consulting>
 <20170113152049.GD5696@atomide.com>
 <CAJ_EiSR-R=5qUKOfHWTTrjj+ZD6Q6BBf1yPj3atf84Q6K03NZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAJ_EiSR-R=5qUKOfHWTTrjj+ZD6Q6BBf1yPj3atf84Q6K03NZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Matt Ranostay <matt@ranostay.consulting> [170113 21:16]:
> On Fri, Jan 13, 2017 at 7:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Matt Ranostay <matt@ranostay.consulting> [170112 19:55]:
> >> We can get audio errors if hitting deeper idle states on omaps:
> >>
> >> [alsa.c:230] error: Fatal problem with alsa output, error -5.
> >> [audio.c:614] error: Error in writing audio (Input/output error?)!
> >>
> >> This seems to happen with off mode idle enabled as power for the
> >> whole SoC may get cut off between filling the McBSP fifo using DMA.
> >> While active DMA blocks deeper idle states in hardware, McBSP
> >> activity does not seem to do so.
> >>
> >> Basing the QoS latency calculation on the FIFO size, threshold,
> >> sample rate, and channels.
> >>
> >> Based on the original patch by Tony Lindgren
> >> Link: https://patchwork.kernel.org/patch/9305867/
> >>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >> ---
> >> Changes from v1:
> >> * add calculations for latency per number of FIFO locations
> >>
> >> Changes from v2:
> >> * add missing mcbsp.h header change
> >>
> >> Changes from v3:
> >> * base the latency calculations on threshold, buffer size, sample
> >>   rate, and channels
> >>
> >> Changes from v4:
> >> * using Peter Ujfalusi's suggestions for restoring a higher latency on
> >>   audio stream completion, or if not applicable remove the QoS request
> >>
> >> Changes from v5:
> >> * clean up latency checking logic
> >> * move logic to .prepare and .shutdown to avoid functions that can sleep
> >>
> >> Changes from v6:
> >> * move QoS removal to asoc_mcbsp_remove from omap_mcbsp_cleanup
> >> * also remove header include that is unneeded
> >
> > Hmm now I'm seeing these when starting or stopping playback:
> 
> Ok I can't reproduce but I have an idea why it is happening. There is
> likely a race condition between pm_qos_remove_request() and
> omap_mcbsp_dai_shutdown()... Should we do a pm_qos_request_active
> check in omap_mcbsp_dai_shutdown? That seems to be hacking around the
> issue.

OK. Again this is with next using omap2plus_defconfig and:

CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

Regards,

Tony
