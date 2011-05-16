From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Mon, 16 May 2011 11:54:55 +0300
Message-ID: <201105161154.55850.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105130859.12477.peter.ujfalusi@ti.com> <BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56808 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab1EPIy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 04:54:59 -0400
In-Reply-To: <BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On Saturday 14 May 2011 05:47:33 Steve Calfee wrote:
> I put in a few debug statements. It appears that my DMA never gets
> started. I know it can work with a different machine and codec driver=
,
> but not mine. I don't see any explicit DMA init, but that must be the
> problem.  Any more ideas?

You mean neither omap_pcm_hw_params nor omap_pcm_trigger got called?
Could you post the output of dmesg related to ASoC? Does the connection=
=20
between the CPU and codec DAI correct?
Does McBSP part got initialized (for example does omap_mcbsp_dai_hw_par=
ams,=20
omap_mcbsp_dai_trigger got called)?

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
