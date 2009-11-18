From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
	fix
Date: Wed, 18 Nov 2009 23:58:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CABBE@dbde02.ent.ti.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<20091114102024.b5c302bb.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091114102024.b5c302bb.jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, "Wang, Jane" <jwang@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> Sent: Saturday, November 14, 2009 1:50 PM
> To: Wang, Jane
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> peter.ujfalusi@nokia.com; broonie@opensource.wolfsonmicro.com
> Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
> 
> Hi
> 
> On Fri, 13 Nov 2009 11:39:47 -0600
> Jane Wang <jwang@ti.com> wrote:
> 
> > McBSP fucntional clock is not disabled when suspend is triggerd which
> > prevents PER domain entering target low-power state. To fix the problem:
> >
> > 1. Disable/enable McBSP functional clock for suspend/resume.
> >
> > 2. In addition, reconfigure McBSP, this is needed when systerm comes out
> of OFF state.
> >
> ...
> > --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> > +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> > @@ -440,6 +440,8 @@ static inline int
> omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
> >  #endif
> >  int omap_mcbsp_request(unsigned int id);
> >  void omap_mcbsp_free(unsigned int id);
> > +void omap_mcbsp_disable_fclk(unsigned int id);
> > +void omap_mcbsp_enable_fclk(unsigned int id);
> ...
> > --- a/sound/soc/omap/omap-mcbsp.c
> > +++ b/sound/soc/omap/omap-mcbsp.c
> > @@ -229,18 +229,28 @@ static int omap_mcbsp_dai_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >
> >  	switch (cmd) {
> >  	case SNDRV_PCM_TRIGGER_START:
> > -	case SNDRV_PCM_TRIGGER_RESUME:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >  		mcbsp_data->active++;
> >  		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
> >  		break;
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +		mcbsp_data->active++;
> > +		omap_mcbsp_enable_fclk(mcbsp_data->bus_id);
> > +		omap_mcbsp_config(mcbsp_data->bus_id,
> > +					&mcbsp_data->regs);
> > +		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
> > +		break;
> >
> For me this looks more like a simple workaround for the audio case than
> comprehensive implementation to McBSP OFF mode context save/restore. My
> thoughts:
> 
> 1. McBSP clock management partially moved out of low-level driver
> 2. McBSP client must do the context restore
> 
> I do know that arch/arm/plat-omap/mcbsp.c enables the clocks in
> omap_mcbsp_request, I don't know do some API or feature there really
> require clocks (or McBSP itself) to be active just after the request
> time but I would look that path instead (even it is more complicated).
> 
> If no API or feature would require active McBSP block before the
> omap_mcbsp_start call, then the clock management could be done inside
> the omap_mcbsp_start/-stop functions.
[Aggarwal, Anuj] I tried doing that but it didn't work because before
_start, we need to call set_hw_params which configures mcbsp, for which
clocks are required.
> 
> Also context save/restore operations belongs more to PM callbacks
> of .../plat-omap/mcbsp.c. Or probably that can be done also dynamically
> inside the omap_mcbsp_start/-stop for keeping the whole McBSP shutdown
> whenever it is idle.
[Aggarwal, Anuj] I am sorry I couldn't understand that. Did you mean that
PM hooks can be added in the mcbsp driver which can be registered and called
As and when required? Any reference driver for this, if my understanding
is correct?
> 
> I think it's worth to look McBSP register cache concept [1] from Janusz
> Krzysztofik would it help all of this context save/restore operations.
[Aggarwal, Anuj] I tried these two patches on omap3 evm but they didn't
work for me. The system doesn't go to the suspend state when I do:
echo mem > /sys/power/state
And the culprits were core (think sdma) and per domain. I tried 
disabling the mcbsp i/f clock as well but it didn't help. On mcbsp 
register dump, I couldn't find the sysconfig register getting 
configured. Could that be the root cause?
> 
> 
> --
> Jarkko
> 
> 1. http://www.spinics.net/lists/linux-omap/msg16720.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
