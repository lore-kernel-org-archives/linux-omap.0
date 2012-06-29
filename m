From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: Panda ES board hang when using GPIO as interrupt
Date: Fri, 29 Jun 2012 09:37:14 +0530
Message-ID: <CAC83ZvJJw-7Xt4Ey4_OT70D6MGHEfwURYVuj5wYTLe5oYiMuRw@mail.gmail.com>
References: <4FE8CF77.5080400@broadcom.com>
	<87txxxs9we.fsf@ti.com>
	<4FEBA854.5010508@broadcom.com>
	<4FEC7B48.8040402@ti.com>
	<4FECCB91.7090609@broadcom.com>
	<4FECD2E5.1060603@ti.com>
	<4FECE067.7000809@broadcom.com>
	<4FECE1BD.80906@ti.com>
	<4FECE45E.6040506@broadcom.com>
	<4FECEE9A.5070300@ti.com>
	<4FECFDD8.5060105@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33359 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab2F2EHQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 00:07:16 -0400
Received: by qcab12 with SMTP id b12so675373qca.32
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 21:07:14 -0700 (PDT)
In-Reply-To: <4FECFDD8.5060105@broadcom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Franky Lin <frankyl@broadcom.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@ti.com>, b-cousson@ti.com, tony@atomide.com, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, grant.likely@secretlab.ca, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 29, 2012 at 6:29 AM, Franky Lin <frankyl@broadcom.com> wrot=
e:
> On 06/28/2012 04:54 PM, Jon Hunter wrote:
>>
>> I am wondering if this could be the bug ... on start-up I see that w=
e do
>> a context restore on bank1 during the probe which is before we have =
done
>> the first suspend! In other words, we could restore a bad/uninitiali=
sed
>> context for bank1. In the case of bank1, the loss count starts at 1 =
and
>> not 0 and so we falsely think we need to perform a restore :-(
>>
>> [ =A0 =A00.176269] omap_gpio_runtime_resume: bank @ 0xfc310000
>> [ =A0 =A00.177276] omap_gpio_runtime_resume: count 0, now 1
>> [ =A0 =A00.177276] gpiochip_add: registered GPIOs 0 to 31 on device:=
 gpio
>> [ =A0 =A00.177642] omap_gpio_runtime_suspend: bank @ 0xfc310000
>>
>> Can you try ...
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index c4ed172..9623408 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1086,6 +1086,9 @@ static int __devinit omap_gpio_probe(struct
>> platform_device *pdev)
>> =A0#ifdef CONFIG_OF_GPIO
>> =A0 =A0 =A0 =A0 bank->chip.of_node =3D of_node_get(node);
>> =A0#endif
>> + =A0 =A0 =A0 if (bank->get_context_loss_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->=
get_context_loss_count(bank->dev);
>>
>> =A0 =A0 =A0 =A0 bank->irq_base =3D irq_alloc_descs(-1, 0, bank->widt=
h, 0);
>> =A0 =A0 =A0 =A0 if (bank->irq_base < 0) {
>>
>
> Looks like you found the culprit. :) It does fix the problem.
So this looks similar to what NeilBrown <neilb@suse.de> reported in
another thread.
The reason was context_loss_count =3D 1 for GPIO BANK#0 which of course=
 is in the
WKUP domain. In fact he tried out with the same fix. Anyways, we
should hear from
Kevin now whether it is feasible to fix the context_loss_count for the =
WKUP GPIO
bank or to put the workaround here in the gpio driver.
--
Tarun
>
> Franky
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
