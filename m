From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Thu, 24 Sep 2009 12:54:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BACC566F@dbde02.ent.ti.com>
References: <2183bec20909221938mf436e87y7620613e160ae6e2@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com>
	<2183bec20909222202u7ada82e1ycb1de4702822e171@mail.gmail.com>
 <20090924094608.542909b7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43332 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZIXHYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 03:24:15 -0400
In-Reply-To: <20090924094608.542909b7.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, hari n <hari.zoom@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hari/Jarkko,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> Sent: Thursday, September 24, 2009 12:16 PM
> To: hari n
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
> 
> On Wed, 23 Sep 2009 00:02:01 -0500
> hari n <hari.zoom@gmail.com> wrote:
> 
> > >>It appears OMAP ALSA driver does not seem to disable and idle the SDMA
> > >>channel on a 'suspend' call. The problem seems to be with the
> > >>'omap_stop_dma()' call under 'SNDRV_PCM_TRIGGER_SUSPEND' in
> > >>'omap_pcm_trigger()'. ALSA audio driver uses self linking and the
> > >>function 'omap_stop_dma()', only unlinks the channels, but DOES NOT
> > >>disable an active channel for linked channels.
> > >>
> Good finding, definitely I was expecting that it will stop the transfer.
> 
> I worder what's the background for current omap_stop_dma
> implementation? I would expect that omap_stop_dma would just stop the
> logical channel without touching the channel linking etc. as there is
> own API for chained transfers and thus omap_stop_dma could be used for
> non-chained transfers or 'hacking' with chained transfers.

> > >>This means after a return from the 'omap_stop_dma()', there can still
> > >>be an active DMA transaction on the channel. Is this the intent Or a
> > >>bug? I can think of situations, where in, we may want to complete the
> > >>DMA transfer and then disable the channel. In such a case, we need to
> > >>wait until the channel is inactive.
> 
> I don't know, probably there is no driver expecting that transfer will
> complete after the omap_stop_dma is called or they explicitly do some
> PIO based FIFO flush for their devices?
> 
> > >>The problem with the current implementation is that after the audio
> > >>platform trigger (suspend) is called, SOC core calls the CPU DAI
> > >>trigger (suspend) and this stops the McBSP. Depending on the current
> > >>DMA pointer, this may leave the DMA channel in active state, since DMA
> > >>is configured for DEST HW Synchronization and and the this never gets
> > >>asserted after the McBSP is stopped..
> > >
> This is true. Then the question is will the operation recover after the
> stream is resumed and after the low-level dma and mcbsp contexts are
> restored and operation started again.
> 
> > >>I see two ways to resolve this issue:
> > >>a) Wait after the 'omap_stop_dma()' in audio platform trigger(suspend)
> > >>until the DMA channel is inactive (i.e buffer transfer complete). But,
> > >>i believe 'trigger' is supposed to be an atomic operation, so we may
> > >>need to wait in a worker thread. And we need to flag the McBSP stop
> > >>based on DMA transfer completion.
> > >>b) Explicitly disable the DMA channel in 'omap_stop_dma().
> > >>
> > >>Option 'b' above may mean losing some data on resume, if we hit 'OFF'
> > >>state during suspend. This may not be a big deal for audio (loss of
> > >>few secs audio), but for other drivers (ex: USB data file transfer?),
> > >>this may not be acceptable. 'Option 'a' means more rework in audio
> > >>driver, but no changes in DAM driver and no loss of data.
> 
> Yeah, trigger callback is atomic and can be called from the interrupt
> context as well. Option 'a' doesn't help losing of audio samples since
> the soc-core is first muting the codec.
> 
> > >>Current Audio driver also does not seem to support 'OFF' mode during
> > >>suspend. It seems to assume that all DMA and McBSP configurations are
> > >>retained in a suspend to resume transition.
> > >>
> It's true, this has not got so much attention. I think I was expecting
> that low-level mcbsp and dma modules will take care of their context
> back-up and restore and that's enough for audio as long as audio will
> inform those modules with _start/_stop calls.
> 
> I don't see any problem if suspend and resume callbacks are added into
> omap-pcm.c and omap-mcbsp.c calling e.g. omap_mcbsp_config if needed.

omap_stop_dma() should be issued when we really want to stop the DMA transfer and issuing this with an outstanding transfer is a BUG in ALSA driver.

Having said that, there is also bug in the DMA driver which doesn't disable the channel in linking cases. Since we use always hardware synchronized method, hardware will take care of draining the buffer so no loss of data.

So option B should be ok and USB case also would work as mentioned above.

Regrads
Santosh
  
