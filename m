From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Sat, 18 Aug 2012 17:58:10 +0200
Message-ID: <CAPo=G1w5N5GVra7TK=En9xnaFmNNP1Zb7g2tZSjg8CO8wewOwA@mail.gmail.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
	<1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
	<20120817130723.GZ11011@atomide.com>
	<502E43BC.30708@bitmer.com>
	<502E4F2B.6060403@ti.com>
	<20120818060810.GH11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37439 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669Ab2HRP6M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Aug 2012 11:58:12 -0400
Received: by yenq9 with SMTP id q9so5364909yen.8
        for <linux-omap@vger.kernel.org>; Sat, 18 Aug 2012 08:58:10 -0700 (PDT)
In-Reply-To: <20120818060810.GH11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

On Sat, Aug 18, 2012 at 8:08 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> Thanks, is this patch still correct so it does not try to enable FIFO
> for 2420?

Yes it only enables the FIFO for 2430, 2420 is not affected.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
