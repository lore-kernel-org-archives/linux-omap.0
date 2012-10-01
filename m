From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Mon, 01 Oct 2012 12:34:07 +0300
Message-ID: <5069638F.1000402@ti.com>
References: <20120920232907.GN28835@atomide.com> <20120927202615.GS4840@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9F522B@DBDE01.ent.ti.com> <CAJ1gdcaU2AcbAJvkFKFGdscZfzMMQRuAmjk6Nf+p-EGhRx4+GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39881 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752538Ab2JAJc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 05:32:58 -0400
Received: by obbuo13 with SMTP id uo13so4732442obb.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Oct 2012 02:32:57 -0700 (PDT)
In-Reply-To: <CAJ1gdcaU2AcbAJvkFKFGdscZfzMMQRuAmjk6Nf+p-EGhRx4+GQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Vutla, Lokesh" <lokeshvutla@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>

Hi,

On 09/28/2012 09:58 AM, Vutla, Lokesh wrote:
> Hi,
> I see a module build failure in linux-next tree.
> Any one else facing this issue or I am missing something.
> Using master branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Below is the log .
>=20
> $ make modules -j 10
> ERROR: "snd_hwparams_to_dma_slave_config"
> [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] u=
ndefined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] unde=
fined!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] und=
efined!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] =
undefined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] u=
ndefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

I have sent a patch fixing this (which also affect other platforms as w=
ell):
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-October/05590=
2.html

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
