From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 26 Apr 2011 09:49:42 -0500
Message-ID: <BANLkTi=3eh+0zRD4jRDPoiGxMgCGeOdrww@mail.gmail.com>
References: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il>
 <1303397412-24813-2-git-send-email-grinberg@compulab.co.il>
 <BANLkTikw73F1RBmJC=+Z2msA3Wr7gG3AGQ@mail.gmail.com> <4DB6D974.6080201@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37532 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755494Ab1DZOuI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 10:50:08 -0400
Received: by wwb28 with SMTP id 28so697455wwb.3
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 07:50:02 -0700 (PDT)
In-Reply-To: <4DB6D974.6080201@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 26, 2011 at 09:40, Igor Grinberg <grinberg@compulab.co.il> =
wrote:
> Hi Nishanth,
>
> On 04/26/11 16:45, Menon, Nishanth wrote:
>
>> On Thu, Apr 21, 2011 at 09:50, Igor Grinberg <grinberg@compulab.co.i=
l> wrote:
>>> replace "printk(KERN_ERR" by "pr_err("
>>> and fix needlessly multi-lined #ifdef
>>>
>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>> ---
>>> =A0arch/arm/mach-omap2/gpmc-smsc911x.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 14 +++++++-------
>>> =A0arch/arm/plat-omap/include/plat/gpmc-smsc911x.h | =A0 =A03 +--
>>> =A02 files changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-om=
ap2/gpmc-smsc911x.c
>>> index d30293a..b45efff 100644
>>> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
>>> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> minor suggestion: wont using pr_fmt help to reduce the need to add %=
s,
>> __func__ for pr_err through out the file?
>
> I don't understand of what "need" are you talking about.
> I don't know of any need to add "%s, __func__" with pr_fmt...
> I've added "%s, __func__" as a meter of choice.
> IMO, it makes it easier to parse the dmesg output.
> If anyone objects it, I can remove them,
> but I think both pr_fmt and __func__ are nice here and
> way better then "printk(KERN_*" with embedded "smsc911x".
Allow me to rephrase.
I like the change of printk->pr_err - thanks for doing it. just
suggesting a minor improvement

if you add the following line before the #includes
#define pr_fmt(fmt) "%s: " fmt, __func__
then
-               printk(KERN_ERR "Failed to request GPIO%d for smsc911x =
IRQ\n",
-                               gpmc_cfg->gpio_irq);
+               pr_err("%s: Failed to request IRQ GPIO%d\n", __func__,
+                      gpmc_cfg->gpio_irq);
becomes,
-               printk(KERN_ERR "Failed to request GPIO%d for smsc911x =
IRQ\n",
-                               gpmc_cfg->gpio_irq);
+               pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio=
_irq);

Both give you exactly the output you would like to see (which I
personally prefer as well), but the second could be lesser lines of
code change ;)

Regards,
Nishanth Menon

>
>>> @@ -55,7 +55,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc91=
1x_platform_data *board_data)
>>> =A0 =A0 =A0 =A0gpmc_cfg =3D board_data;
>>>
>>> =A0 =A0 =A0 =A0if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_ba=
se) < 0) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GP=
MC mem for smsc911x\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to request GPMC me=
m region\n", __func__);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> =A0 =A0 =A0 =A0}
>>>
>>> @@ -63,8 +63,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc91=
1x_platform_data *board_data)
>>> =A0 =A0 =A0 =A0gpmc_smsc911x_resources[0].end =3D cs_mem_base + 0xf=
f;
>>>
>>> =A0 =A0 =A0 =A0if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq")=
 < 0) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GP=
IO%d for smsc911x IRQ\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_=
cfg->gpio_irq);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to request IRQ GPI=
O%d\n", __func__,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cfg->gpio_irq);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free1;
>>> =A0 =A0 =A0 =A0}
>>>
>>> @@ -74,8 +74,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc91=
1x_platform_data *board_data)
>>> =A0 =A0 =A0 =A0if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D gpio_request(gpmc_cfg->gpio_=
reset, "smsc911x reset");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Fail=
ed to request GPIO%d for smsc911x reset\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 gpmc_cfg->gpio_reset);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to=
 request reset GPIO%d\n", __func__,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_c=
fg->gpio_reset);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free2;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> @@ -92,7 +92,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc91=
1x_platform_data *board_data)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_smsc911x_resources, ARRAY_SIZE=
(gpmc_smsc911x_resources),
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gpmc_smsc911x_config, sizeof(gpmc_=
smsc911x_config));
>>> =A0 =A0 =A0 =A0if (!pdev) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register s=
msc911x device\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unable to register platfo=
rm device\n", __func__);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(gpmc_cfg->gpio_reset);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free2;
>>> =A0 =A0 =A0 =A0}
>>> @@ -104,5 +104,5 @@ free2:
>>> =A0free1:
>>> =A0 =A0 =A0 =A0gpmc_cs_free(gpmc_cfg->cs);
>>>
>>> - =A0 =A0 =A0 printk(KERN_ERR "Could not initialize smsc911x\n");
>>> + =A0 =A0 =A0 pr_err("Could not initialize smsc911x\n");
>>> =A0}
>>> diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch=
/arm/plat-omap/include/plat/gpmc-smsc911x.h
>>> index d3f1579..ea6c9c8 100644
>>> --- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>>> +++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>>> @@ -21,8 +21,7 @@ struct omap_smsc911x_platform_data {
>>> =A0 =A0 =A0 =A0u32 =A0 =A0 flags;
>>> =A0};
>>>
>>> -#if defined(CONFIG_SMSC911X) || \
>>> - =A0 =A0 =A0 defined(CONFIG_SMSC911X_MODULE)
>>> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
>>>
>>> =A0extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_dat=
a *d);
>>>
>>> --
>>> 1.7.3.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>
> --
> Regards,
> Igor.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
