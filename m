From: "Ghongdemath, Girish" <girishsg@ti.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value to int
Date: Mon, 13 Jun 2011 11:37:01 -0500
Message-ID: <BANLkTimi0RZ8Fe7VpY9J7dMPH6tpVzf=dw@mail.gmail.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	<1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
	<1307958710.1847.56.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51671 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753561Ab1FMQhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 12:37:04 -0400
In-Reply-To: <1307958710.1847.56.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: paul@pwsan.com, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

Tomi,
Couple of queries,

On Mon, Jun 13, 2011 at 4:51 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Paul, can you take this patch and queue it for an rc?
>
> =A0Tomi
>
> On Thu, 2011-06-09 at 16:56 +0300, Tomi Valkeinen wrote:
>> get_context_loss_count functions return context loss count as u32, a=
nd
>> zero means an error. However, zero is also returned when context has
>> never been lost and could also be returned when the context loss cou=
nt
>> has wrapped and goes to zero.
>>
>> Change the functions to return an int, with negative value meaning a=
n
>> error.
>>

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (off_mode_enabled) {

- why have a check for off_mode_enabled? As this only detects valid
next state for MPU/CORE. Other pwrdm can still
hit OFF.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context loss count ha=
s to be a non-negative value.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Clear the sign bit to=
 get a value range from 0 to
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* INT_MAX.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count &=3D INT_MAX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_context_loss_counter=
 =3D count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }

- Why not use u32 instead?


Regards,
Girish

>>
>> =A0 =A0 =A0 pr_debug("OMAP PM: context loss count for dev %s =3D %d\=
n",
>> @@ -337,7 +347,7 @@ u32 omap_pm_get_dev_context_loss_count(struct de=
vice *dev)
>>
>> =A0#else
>>
>> -u32 omap_pm_get_dev_context_loss_count(struct device *dev)
>> +int omap_pm_get_dev_context_loss_count(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 return dummy_context_loss_counter;
>> =A0}
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
>> index 9bbda9a..9753f71 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -310,7 +310,7 @@ static void _add_optional_clock_clkdev(struct om=
ap_device *od,
>> =A0 * return the context loss counter for that hwmod, otherwise retu=
rn
>> =A0 * zero.
>> =A0 */
>> -u32 omap_device_get_context_loss_count(struct platform_device *pdev=
)
>> +int omap_device_get_context_loss_count(struct platform_device *pdev=
)
>> =A0{
>> =A0 =A0 =A0 struct omap_device *od;
>> =A0 =A0 =A0 u32 ret =3D 0;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
