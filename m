From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v2 4/4] OMAP4: DSS2: clocks: Add ick as dummy clock
Date: Fri, 28 Jan 2011 10:29:07 +0530
Message-ID: <AANLkTimD_JBR8wcKnxyFGVDjHhigAhhUqPJNnKC=PvhS@mail.gmail.com>
References: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
 <1295960398-25329-5-git-send-email-sumit.semwal@ti.com> <87k4hqp7d1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55392 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754772Ab1A1E7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 23:59:30 -0500
Received: by mail-bw0-f44.google.com with SMTP id 12so3080342bwz.17
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 20:59:28 -0800 (PST)
In-Reply-To: <87k4hqp7d1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com

On Thu, Jan 27, 2011 at 11:16 PM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
>> DSS code uses ick as one of the clocks in clk_get/clk_put. OMAP4 clo=
ck database
>> doesn't have ick for DSS, so adding ick as dummy clock.
>>
>> Once pm_runtime* APIs get introduced in DSS, this will be revisited.
>>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index 74db324..8603b1f 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3109,6 +3109,8 @@ static struct omap_clk omap44xx_clks[] =3D {
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "dsp_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&dsp_fck, =A0 =A0 =A0 CK_443X),
>> =A0 =A0 =A0 /* dss clocks */
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "fck", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0&dss_fck, =A0 =A0 =A0 CK_443X),
>> + =A0 =A0 CLK("omap_dss", "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 /* on OMAP4, ick is a dummy clock */
>
> minor nit: the comment should go above the code, and should also stat=
e
> it's needed for OMAP2/3 compatibility.
Sure, thanks! Will update in next version.
~Sumit.
>
> Kevin
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* clocks handled via hwmod opt_clk mechanism need dev=
=3DNULL,
>> =A0 =A0 =A0 =A0* con=3Dclock name as per actual clk structure, NOT r=
ole
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
