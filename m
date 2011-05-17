From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Tue, 17 May 2011 13:42:34 +0300
Message-ID: <201105171342.35056.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105161154.55850.peter.ujfalusi@ti.com> <4DD167EC.2010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43117 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab1EQKmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 06:42:38 -0400
In-Reply-To: <4DD167EC.2010007@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

Hi,

On Monday 16 May 2011 21:07:40 Steve Calfee wrote:
> No, they get called. I just don't get the clock on the bclk pin.

OK.
Could you try to disconnect the CLKX, and FSX lines from OMAP, and see =
that=20
you have the clocks on the codec side?
If in this way you still can not see the clocks, than your codec (max98=
095 ?)=20
is not generating the clocks.
Could you also post from your machine driver how you configure the form=
ats for=20
cpu/codec DAI (snd_soc_dai_set_fmt call)?

While the clock lines are not physically connected, you can try to conf=
igure=20
either side to generate the correct clocks on the lines. When you see t=
hat,=20
you can connect them together, and see (hear) if it works.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
