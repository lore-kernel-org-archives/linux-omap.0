From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V2 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Date: Tue, 27 Mar 2012 16:44:04 +0530
Message-ID: <CAF0AtAuxR6pa0y_kTgh454=joFoy_kG4XCnHAS94qkPk0+kLFw@mail.gmail.com>
References: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
	<1332846215.1867.130.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:47264 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab2C0LOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:14:07 -0400
Received: by lbbgi11 with SMTP id gi11so4590753lbb.9
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:14:04 -0700 (PDT)
In-Reply-To: <1332846215.1867.130.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Mar 27, 2012 at 4:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-03-21 at 15:22 +0530, Chandrabhanu Mahapatra wrote:
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
>> =A0drivers/video/omap2/dss/dispc.c | =A0 13 +++++++------
>> =A01 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index d8a1672..1fdac73 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1761,6 +1761,7 @@ static int dispc_ovl_calc_scaling(enum omap_pl=
ane plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_feat=
_get_param_max(FEAT_PARAM_LINEWIDTH);
>> =A0 =A0 =A0 const int max_decim_limit =3D 16;
>> =A0 =A0 =A0 unsigned long fclk =3D 0;
>> + =A0 =A0 unsigned long dispc_core_clk =3D dispc_mgr_lclk_rate(chann=
el);
>
> Hmm, I don't think this is correct. dispc_mgr_lclk_rate() returns the
> logic clock for the LCD output path. It's not DISPC core clock.
>
> =A0Tomi
>

As per the OMAP4 TRM DISPC_CORE_CLK is DISPC_FCLK / LCD factor and
dispc_mgr_lclk_rate() exactly does the same. Should we rename the
function or have a separate fucntion for dispc_core_clk to avoid
confusion?

--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
