From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Date: Mon, 23 Apr 2012 10:05:32 +0530
Message-ID: <CAF0AtAu6xhQmQZLbW9keTMjcSfPwsVUoWa7e4fsSpHXms+pVSQ@mail.gmail.com>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
	<1334928673-27943-1-git-send-email-cmahapatra@ti.com>
	<1334932153.2058.40.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:46698 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059Ab2DWEfe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 00:35:34 -0400
Received: by obbup16 with SMTP id up16so8470596obb.15
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 21:35:33 -0700 (PDT)
In-Reply-To: <1334932153.2058.40.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Apr 20, 2012 at 7:59 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2012-04-20 at 19:01 +0530, Chandrabhanu Mahapatra wrote:
>> DISPC_FCLK is incorrectly used as functional clock of DISPC in scali=
ng
>> calculations. So, DISPC_CORE_CLK replaces as functional clock of DIS=
PC.
>> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent =
DISPC
>> divisor LCD.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 25 +++++++++++++++++++-----=
-
>> =A0drivers/video/omap2/dss/dss.h =A0 | =A0 =A01 +
>> =A02 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index 17ffa71..0417423 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1855,7 +1855,7 @@ static int dispc_ovl_calc_scaling(enum omap_pl=
ane plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D calc_fclk(chann=
el, in_width, in_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 out_width, out_height);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D (in_width > ma=
xsinglelinewidth || !fclk ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk > dis=
pc_fclk_rate());
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk > dis=
pc_core_clk_rate());
>
> The patch is now otherwise fine, but I think it needs some more
> renaming. Now the code mixes fclk and core-clk names, which is rather
> confusing. I guess the calc_fclk should actually be calc_req_core_clk=
?
> And the fclk variable core_clk (or cclk or something)?
>
> =A0Tomi
>

As per TRM dispc_core_clk is also a functional clock, so I think above
code should be fine. But, to avoid confusion of names the renaming of
fclk, calc_fclk and calc_fclk_five_taps can be done.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
