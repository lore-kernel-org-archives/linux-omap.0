From: Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] regulator: twl: Add 'fixed' set_voltage callback
Date: Fri, 24 Jun 2011 18:36:10 +0530
Message-ID: <BANLkTi=pWMmfH+GV_kwm8_MtjPpsdNWD6w@mail.gmail.com>
References: <1308862014-11212-1-git-send-email-jaswinder.singh@linaro.org>
	<20110624111929.GC9483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65251 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1FXNGM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 09:06:12 -0400
In-Reply-To: <20110624111929.GC9483@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, ti@lists.linaro.org, linux-omap@vger.kernel.org, lrg@ti.com, sameo@linux.intel.com

On 24 June 2011 16:49, Mark Brown <broonie@opensource.wolfsonmicro.com>=
 wrote:
> On Fri, Jun 24, 2011 at 02:16:54AM +0530, Jassi Brar wrote:
>> Define dummy set_voltage callback for fixed lines,
>> without which voltage constraints fail to apply.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>
> No, this isn't sensible - fixed voltage regulators aren't an unusual
> property of this device, they've very common. =C2=A0The core should h=
andle
> this gracefully. =C2=A0Probably whatever consumer is doing the settin=
g also
> ought to be updated to check that the voltages it wants to set are
> supported at startup since

Well, there's no consumer in the picture yet. The core even fails to re=
gister
the regulator.
After digging deeper, I realized removing
       .apply_uV =3D true;
from the constraints is the correct solution. Patch is coming next.

> otherwise it can end up repeatedly trying to
> set something that'll never work.
Though the semantic could be defined that the 'closest' possible value
is already
set after the set_{voltage,current_limit} returns.
The consumer has no point in retrying - just like sample-rate setting
in Alsa works.

Thanks,
Jassi

--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106 =C2=A0-
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
