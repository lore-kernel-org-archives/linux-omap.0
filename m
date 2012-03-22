From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 13/13] Add dummy smsc911x regulators to zoom-debugboard.
Date: Thu, 22 Mar 2012 11:29:23 -0700
Message-ID: <CA+Bv8XZudbzx_CpiYzOJ5q9BvcBDJiWzxfCakEGzODN-6Mv03Q@mail.gmail.com>
References: <20120321194133.GP9859@atomide.com>
	<1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
	<1332393594-23993-14-git-send-email-Russ.Dill@ti.com>
	<20120322113722.GF3091@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54538 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab2CVS3X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 14:29:23 -0400
Received: by pbcun15 with SMTP id un15so1788384pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 11:29:23 -0700 (PDT)
In-Reply-To: <20120322113722.GF3091@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

On Thu, Mar 22, 2012 at 4:37 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 21, 2012 at 10:19:54PM -0700, Russ Dill wrote:
>
>> +static struct regulator_consumer_supply dummy_supplies[] =3D {
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>
> Why do none of these boards use -1 as the ID for the device?

Commit 21b42731 (omap: convert boards that use SMSC911x to use
gpmc-smsc911x) changed several board files to use the gpmc-smsc911x.c
common code rather than register the device themselves, in the process
it changed many of the id's from -1 to 0. This happened in the 3.0
merge window. I can certainly change it back.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
