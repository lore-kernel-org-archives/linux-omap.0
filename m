From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] Don't clobber access methods when !regmap
Date: Thu, 6 Sep 2012 17:02:46 +0300
Message-ID: <1C46E0E7-6D8F-4FD7-B9BC-40C322D423C8@antoniou-consulting.com>
References: <1346939132-20187-1-git-send-email-panto@antoniou-consulting.com> <50477FA9.8060905@metafoo.de> <D96C7824-5EBC-4418-B016-DCE395A720D7@antoniou-consulting.com> <5048ACAA.3000505@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5048ACAA.3000505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sep 6, 2012, at 5:01 PM, Peter Ujfalusi wrote:

> Hi,
>=20
> On 09/05/2012 07:43 PM, Pantelis Antoniou wrote:
>> The driver in question (twl4030.c) does not call snd_soc_codec_set_c=
ache_io().
>> However the snd-soc core does call it in sound/soc/soc-core.c in soc=
_probe_codec.
>>=20
>> I do see that there's a commit 98d3088e534a2a61f6690b5426909b0c3b57a=
785 that is
>> fixing it in a different manner.
>=20
> I also noticed this (with 3.6-rc1 I think).
> The commit you mention does fix it so we do not have issue anymore.
> I sent two patches related to this:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/0538=
64.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/0538=
76.html
>=20
> Mark took a different route which gives us the commit you mentioned:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/0538=
89.html
>=20
> Regards,
> P=E9ter

Quite similar to my patches. They're not needed now, since I have verif=
ied that
the issue is fixed.

Regards

-- Pantelis
