From: hari n <hari.zoom@gmail.com>
Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Wed, 23 Sep 2009 00:02:01 -0500
Message-ID: <2183bec20909222202u7ada82e1ycb1de4702822e171@mail.gmail.com>
References: <2183bec20909221938mf436e87y7620613e160ae6e2@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:34671 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbZIWFB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 01:01:57 -0400
Received: by ywh4 with SMTP id 4so508424ywh.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 22:02:01 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9DAFC82@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 22, 2009 at 10:20 PM, Pandita, Vikram <vikram.pandita@ti.co=
m> wrote:
>
>
>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of hari n
>>Sent: Tuesday, September 22, 2009 9:38 PM
>>To: linux-omap@vger.kernel.org
>>Subject: [OMAP3] ALSA driver 'suspend/resume' handlers
>>
>>Hi,
>>
>>It appears OMAP ALSA driver does not seem to disable and idle the SDM=
A
>>channel on a 'suspend' call. The problem seems to be with the
>>'omap_stop_dma()' call under 'SNDRV_PCM_TRIGGER_SUSPEND' in
>>'omap_pcm_trigger()'. ALSA audio driver uses self linking and the
>>function 'omap_stop_dma()', only unlinks the channels, but DOES NOT
>>disable an active channel for linked channels.
>>
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(dma_chan_link_map, 0, sizeof(dm=
a_chan_link_map));
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* The loop case: we'v=
e been here already */
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dma_chan_link_map[=
cur_lch])
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Mark the current ch=
annel */
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_chan_link_map[cur_=
lch] =3D 1;
>>
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_lnk(cur_lch);
>
> What if we introduce this code here?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Stop the Channel tr=
ansmission */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D =
dma_read(CCR(cur_lch));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D=
 ~(1 << OMAP_DMA_CCR_EN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_wr=
ite(l, CCR(cur_lch));
>
This may result in disabling an active DMA channel.. Which can lead to
un-drained FIFOs, if we do not wait to check for 'RD_ACTIVE',
'WR_ACTIVE' bits (refer to 'Disabling a channel during transfer' and
'FIFO draining mechanism'. In addition, as i mentioned below we may
also lose data..
>>
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0next_lch =3D dma_chan[=
cur_lch].next_lch;
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_lch =3D next_lch;
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (next_lch !=3D -1);
>>
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return; <---
>>=A0 =A0 =A0 =A0}
>>
>>This means after a return from the 'omap_stop_dma()', there can still
>>be an active DMA transaction on the channel. Is this the intent Or a
>>bug? I can think of situations, where in, we may want to complete the
>>DMA transfer and then disable the channel. In such a case, we need to
>>wait until the channel is inactive.
>>The problem with the current implementation is that after the audio
>>platform trigger (suspend) is called, SOC core calls the CPU DAI
>>trigger (suspend) and this stops the McBSP. Depending on the current
>>DMA pointer, this may leave the DMA channel in active state, since DM=
A
>>is configured for DEST HW Synchronization and and the this never gets
>>asserted after the McBSP is stopped..
>
> If you check the chaining DMA api: omap_stop_dma_chain_transfers() ha=
s this kind of code:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop the Channel transmission */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D dma_read(CCR(channels[i]));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~(1 << 7);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(l, CCR(channels[i]));
>
> Should audio be using chaining api's?
> Not sure how linking and chaining are related though.
> Is self-linking a case of chaining with two same elements?
>
Here again, we have the same issue of disabling the channels, while
some data may be in the FIFO/flight..
>
>>
>>I see two ways to resolve this issue:
>>a) Wait after the 'omap_stop_dma()' in audio platform trigger(suspend=
)
>>until the DMA channel is inactive (i.e buffer transfer complete). But=
,
>>i believe 'trigger' is supposed to be an atomic operation, so we may
>>need to wait in a worker thread. And we need to flag the McBSP stop
>>based on DMA transfer completion.
>>b) Explicitly disable the DMA channel in 'omap_stop_dma().
>>
>>Option 'b' above may mean losing some data on resume, if we hit 'OFF'
>>state during suspend. This may not be a big deal for audio (loss of
>>few secs audio), but for other drivers (ex: USB data file transfer?),
>>this may not be acceptable. 'Option 'a' means more rework in audio
>>driver, but no changes in DAM driver and no loss of data.
>>Current Audio driver also does not seem to support 'OFF' mode during
>>suspend. It seems to assume that all DMA and McBSP configurations are
>>retained in a suspend to resume transition.
>>
>>Thanks
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
