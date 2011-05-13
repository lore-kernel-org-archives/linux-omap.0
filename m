From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 13 May 2011 08:59:12 +0300
Message-ID: <201105130859.12477.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105121401.44607.peter.ujfalusi@ti.com> <4DCC2A48.7070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58215 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab1EMF7Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 01:59:16 -0400
In-Reply-To: <4DCC2A48.7070602@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On Thursday 12 May 2011 21:43:20 Steve Calfee wrote:
> Since it is set to 0xF0F, doesn't this set it as master?

Sorry, that is correct, McBSP is configured as msater.

> Also, spelunking the kernel sources, I cannot seem to find the source
> for mcbsp_data->regs -- do you know where it gets set initially?

They configured within sound/soc/omap/omap-pcm.c

Have you configured the clk source, and divider correctly for McBSP por=
t from=20
the machine driver (with snd_soc_dai_set_sysclk)?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
