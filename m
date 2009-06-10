From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Wed, 10 Jun 2009 14:20:01 +0200
Message-ID: <4A2FA4F1.8070208@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906101112.32635.peter.ujfalusi@nokia.com> <200906101227.39856.jkrzyszt@tis.icnet.pl> <200906101353.43411.peter.ujfalusi@nokia.com>
Reply-To: postmaster@icnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56484 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbZFJMUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2009 08:20:05 -0400
In-Reply-To: <200906101353.43411.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Peter Ujfalusi wrote:
> On Wednesday 10 June 2009 13:27:38 ext Janusz Krzysztofik wrote:
>> Not only this. AFAICS, there is no way of specifying single phase stereo
>> (with XPHASE/RPHASE unset), 2 words per frame (XFRLEN1/RFRLEN1(2 - 1)).
>> Isn't this required for correct DSP_A/DSP_B support?
> 
> Sure it is possible:
> 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> 	wpf = channels = params_channels(params);
> 	switch (channels) {
> 	case 2:
> 		if (format == SND_SOC_DAIFMT_I2S) {
> 			/* Use dual-phase frames */
> 			regs->rcr2	|= RPHASE;
> 			regs->xcr2	|= XPHASE;
> 			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> 			wpf--;
> 			regs->rcr2	|= RFRLEN2(wpf - 1);
> 			regs->xcr2	|= XFRLEN2(wpf - 1);
> 		}
> 	case 1:
> 	case 4:
> 		/* Set word per (McBSP) frame for phase1 */
> 		regs->rcr1	|= RFRLEN1(wpf - 1);
> 		regs->xcr1	|= XFRLEN1(wpf - 1);
> 		break;
> 	default:
> 		/* Unsupported number of channels */
> 		return -EINVAL;
> 	}
> 
> wpf = channels == 2, format is not I2S --> RFRLEN1(wpf - 1), XFRLEN1(wpf - 1), 
> RFRLEN1(2 - 1), XFRLEN1(2 - 1)

OK, I see I have to update my base before commenting the code ;).

Thanks,
Janusz
