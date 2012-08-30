From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 02/14] MFD: twl4030-audio: Convert to use devm_kzalloc
Date: Thu, 30 Aug 2012 12:19:22 +0300
Message-ID: <503F301A.1090200@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>  <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com> <1346147410.2182.96.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346147410.2182.96.camel@sokoban>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On 08/28/2012 12:50 PM, Tero Kristo wrote:
> On Tue, 2012-08-14 at 17:22 +0300, Peter Ujfalusi wrote:
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> I think this one could use a short commit message, also about why
> kfree():s are dropped (handled internally by devm_* etc.)

I don't like empty commit messages either but this patch is self explai=
ning I
would think that the commit title explains it.

--=20
P=C3=A9ter
