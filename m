From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Tue, 7 Dec 2010 11:05:47 +0530
Message-ID: <AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1290689318-10191-11-git-send-email-charu@ti.com> <AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54825 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab0LGFg3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 00:36:29 -0500
Received: by mail-iw0-f175.google.com with SMTP id 8so12816703iwn.6
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:36:28 -0800 (PST)
In-Reply-To: <AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, Rajendra Nayak <rnayak@ti.com>

Cory,

On Tue, Dec 7, 2010 at 10:49, Cory Maccarrone <darkstar6262@gmail.com> =
wrote:
> On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.co=
m> wrote:

<<snip>>

>> @@ -1642,6 +1502,13 @@ static int gpio_debounce(struct gpio_chip *ch=
ip, unsigned offset,
>> =A0 =A0 =A0 =A0unsigned long flags;
>>
>> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
>> +
>> + =A0 =A0 =A0 if (!bank->dbck) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck =3D clk_get(bank->dev, "dbc=
lk");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "Co=
uld not get gpio dbck\n");
>> + =A0 =A0 =A0 }
>> +
>
> I'm testing this on omap7xx, which doesn't have a dbclk. =A0Even with
> dbck_flag set to false, this code still runs, causing these messages
> to show up:

Thanks for testing this series on OMAP7xx.

>
> =A0 =A0omap_gpio omap_gpio.5: Could not get gpio dbck
> =A0 =A0omap_gpio omap_gpio.6: Could not get gpio dbck
>
> I think that 'if' should be:
>
> =A0 =A0if (bank->dbck_flag && !bank->dbck) {

You are right. Will send a patch now.

>
> Also, see my comments in patch 4 - OMAP7xx: GPIO: Introduce support
> for GPIO init, as there's dbck_flag entries there that are needed for
> omap7xx. =A0Otherwise, seems to work well.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
