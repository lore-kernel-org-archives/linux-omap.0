From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: receiving data from mcbsp1 in master mode
Date: Thu, 23 Aug 2012 11:47:59 +0300
Message-ID: <5035EE3F.9000903@ti.com>
References: <20120821074205.0a36f648@kemnade.info> <5033903B.8000009@ti.com> <20120822221942.2ebb4fd3@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:44609 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753405Ab2HWIsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 04:48:05 -0400
Received: by obbeh20 with SMTP id eh20so873957obb.10
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 01:48:03 -0700 (PDT)
In-Reply-To: <20120822221942.2ebb4fd3@kemnade.info>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-omap@vger.kernel.org

On 08/22/2012 11:19 PM, Andreas Kemnade wrote:
> if I understand the TRM correctly, according to Figure 21-26 in chapt=
er 21.4.2.3.
> if GSYNC is set, the receiver uses the signal from the sample rate ge=
nerator,
> so CLKX does not need to be the CLKR source.
> But I tried also with the DEVCONF0 MCBSP1_CLKR bit as you proposed.
> I tried
>  snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
>                                      SND_SOC_CLOCK_OUT);
>  snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
>                                      SND_SOC_CLOCK_OUT);

There is an issue with the 6pin mux code, try to add this patch:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054041=
=2Ehtml

>  That is why I send you my patch about that mux settings. But I had n=
o success.
> The CLKX as CLKR source and FSX as FSR source setting I have only see=
n when
> mcbsp1 is used in slave mode. If you know any working code which uses=
 mcbsp1 in
> master mode then let me know.

No, I don't have board which uses McBSP1.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
