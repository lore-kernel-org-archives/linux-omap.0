From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Don't clobber access methods when !regmap
Date: Thu, 06 Sep 2012 17:01:14 +0300
Message-ID: <5048ACAA.3000505@ti.com>
References: <1346939132-20187-1-git-send-email-panto@antoniou-consulting.com> <50477FA9.8060905@metafoo.de> <D96C7824-5EBC-4418-B016-DCE395A720D7@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D96C7824-5EBC-4418-B016-DCE395A720D7@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/05/2012 07:43 PM, Pantelis Antoniou wrote:
> The driver in question (twl4030.c) does not call snd_soc_codec_set_ca=
che_io().
> However the snd-soc core does call it in sound/soc/soc-core.c in soc_=
probe_codec.
>=20
> I do see that there's a commit 98d3088e534a2a61f6690b5426909b0c3b57a7=
85 that is
> fixing it in a different manner.

I also noticed this (with 3.6-rc1 I think).
The commit you mention does fix it so we do not have issue anymore.
I sent two patches related to this:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/053864=
=2Ehtml
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/053876=
=2Ehtml

Mark took a different route which gives us the commit you mentioned:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/053889=
=2Ehtml

Regards,
P=E9ter
