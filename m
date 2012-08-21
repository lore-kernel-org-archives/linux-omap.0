From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V5 5/6] ARM: OMAP: Disable venc for OMAP4
Date: Tue, 21 Aug 2012 16:43:05 +0530
Message-ID: <CAF0AtAv6hGf0LriC=WafsrF2ihw_3P6-wv75aq+UT_xvaPgh5A@mail.gmail.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
	<cover.1345468541.git.cmahapatra@ti.com>
	<a07a3a216827e830cfa249f4f39ad26e75dc0afd.1345468541.git.cmahapatra@ti.com>
	<1345545159.4085.45.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:50345 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756889Ab2HULNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:13:06 -0400
Received: by vbbff1 with SMTP id ff1so7712035vbb.5
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 04:13:05 -0700 (PDT)
In-Reply-To: <1345545159.4085.45.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 21, 2012 at 4:02 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 18:54 +0530, Chandrabhanu Mahapatra wrote:
>> This is a alternative to "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to
>> prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> to prevent
>> VENC from crashing OMAP4 kernel. This prevents OMAPDSS from initial registration
>> of a device for VENC on OMAP4.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  arch/arm/mach-omap2/display.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>> index af1ed7d..ee40739 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -95,7 +95,6 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
>>       { "dss_core", "omapdss_dss", -1 },
>>       { "dss_dispc", "omapdss_dispc", -1 },
>>       { "dss_rfbi", "omapdss_rfbi", -1 },
>> -     { "dss_venc", "omapdss_venc", -1 },
>>       { "dss_dsi1", "omapdss_dsi", 0 },
>>       { "dss_dsi2", "omapdss_dsi", 1 },
>>       { "dss_hdmi", "omapdss_hdmi", -1 },
>
> You need to reorder this and the previous patch. If you first remove the
> workaround from the previous patch, the kernel will crash if after that
> patch. So this one should be before the previous patch.
>
>  Tomi
>

Ok.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
