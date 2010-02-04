From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Thu, 4 Feb 2010 16:52:26 +0200
Message-ID: <6ed0b2681002040652r722e3df2s3f032a9fe0d0c0fe@mail.gmail.com>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
	 <20100204142439.GA1139@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:42269 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005Ab0BDOw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 09:52:29 -0500
In-Reply-To: <20100204142439.GA1139@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 4, 2010 at 4:24 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Feb 04, 2010 at 03:39:18PM +0200, Grazvydas Ignotas wrote:
>
>> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
>> connected to various regulators for power, so add regulator support.
>> Make it optional for now to avoid breaking all current users of this
>> driver.
>
> This should not be required. =A0The regulator API stubs itself out wh=
en it
> is not built so all API calls report as successful.

ok

>
>> + =A0 =A0 ts->reg =3D regulator_get(&spi->dev, "vcc");
>> + =A0 =A0 if (!IS_ERR(ts->reg)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D regulator_enable(ts->reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_regulator;
>> + =A0 =A0 }
>
> If the regulator API is not compiled in then the regulator_get() will
> return succesfully. =A0If the regulator API is in use then failure to
> acquire the regulator is a serious problem which really should be at =
a
> minimium be being communicated to the user. =A0For example, the regul=
ator
> API may end up powering down regulators which it believes are unused =
or
> the regulator may not be powered by default and needs to be enabled.
>
> The updates to fix up the boards that need this are fairly
> straightforward and given that it's fairly easy to identify systems
> which are using the driver in mainline so I'd really prefer not to go
> down the route of trying to carry on in the face of error, it papers
> over stuff now but is not robust in the face of future changes.

What about warning and continuing only on ENODEV then? I really don't
want to be responsible for potentially breaking touchscreen on ~30
boards, where I have no idea about how things are wired up and how the
regulators should be set up.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
