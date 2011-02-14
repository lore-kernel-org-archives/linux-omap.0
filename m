From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v10 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
Date: Tue, 15 Feb 2011 00:05:10 +0530
Message-ID: <AANLkTimMhZgen-QMguBOs1rNpNqrg68FP_NUTmO1+Ucd@mail.gmail.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
 <1295850125-21405-19-git-send-email-sumit.semwal@ti.com> <1297692573.2951.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40397 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751474Ab1BNSfc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 13:35:32 -0500
Received: by yws5 with SMTP id 5so2211881yws.30
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:35:31 -0800 (PST)
In-Reply-To: <1297692573.2951.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi,

On Mon, Feb 14, 2011 at 7:39 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>
> On Mon, 2011-01-24 at 11:52 +0530, ext Sumit Semwal wrote:
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> DSS IRQ number can be obtained from platform_get_irq(). =A0This API =
in turn
>> picks the right IRQ number belonging to HW IP from the hwmod databas=
e.
>> So hardcoding of IRQ number could be removed.
>>
>> Reviewed-by: Paul Walmsley <paul@pwsan.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dss.c | =A0 21 ++++++++++++++-------
>> =A01 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>> index 4d7a816..f9390b4 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -563,7 +563,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>>
>> =A0static int dss_init(bool skip_init)
>> =A0{
>> - =A0 =A0 int r;
>> + =A0 =A0 int r, dss_irq;
>> =A0 =A0 =A0 u32 rev;
>> =A0 =A0 =A0 struct resource *dss_mem;
>>
>> @@ -609,11 +609,18 @@ static int dss_init(bool skip_init)
>> =A0 =A0 =A0 REG_FLD_MOD(DSS_CONTROL, 0, 2, 2); =A0 =A0 =A0/* venc cl=
ock mode =3D normal */
>> =A0#endif
>>
>> - =A0 =A0 r =3D request_irq(INT_24XX_DSS_IRQ,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_is_omap24xx()
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? dss_irq_handler_omap2
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : dss_irq_handler_omap3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, "OMAP DSS", NULL);
>> + =A0 =A0 dss_irq =3D platform_get_irq(dss.pdev, 0);
>> + =A0 =A0 if (dss_irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("omap2 dss: platform_get_irq failed=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 r =3D request_irq(dss_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_is_omap24xx()
>> + =A0 =A0 =A0 =A0 =A0 =A0 ? dss_irq_handler_omap2
>> + =A0 =A0 =A0 =A0 =A0 =A0 : dss_irq_handler_omap3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 0, "OMAP DSS", NULL);
>>
>> =A0 =A0 =A0 if (r < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("omap2 dss: request_irq failed\n"=
);
>> @@ -641,7 +648,7 @@ static int dss_init(bool skip_init)
>> =A0 =A0 =A0 return 0;
>>
>> =A0fail2:
>> - =A0 =A0 free_irq(INT_24XX_DSS_IRQ, NULL);
>> + =A0 =A0 free_irq(dss_irq, NULL);
>
> You change this free_irq, as you should, but you missed another a few
> lines later.
>
> Archit fixes it in his "OMAP: DSS2: Common IRQ handler for all OMAPs"
> patch silently, but I think it should be fixed here already, as the
> patches haven't been pulled to anywhere yet.
>
> Perhaps you could use the same method as Archit used, create a new fi=
eld
> "irq" in the dss struct which can be used in the dss_exit's free_irq
> call.
Yes, you're right; I guess since it was already in your tree by the
time we noticed this oversight, we assumed Archit could submit a new
one. I can send you an updated one tomorrow for this.

Regards,
~Sumit.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
