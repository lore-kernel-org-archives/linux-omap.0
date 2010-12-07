From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Tue, 7 Dec 2010 12:38:08 +0530
Message-ID: <AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1290689318-10191-11-git-send-email-charu@ti.com> <AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
 <AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54695 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752687Ab0LGHIt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 02:08:49 -0500
Received: by mail-iw0-f171.google.com with SMTP id 35so634881iwn.2
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 23:08:48 -0800 (PST)
In-Reply-To: <AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, Rajendra Nayak <rnayak@ti.com>

On Tue, Dec 7, 2010 at 11:05, Varadarajan, Charulatha <charu@ti.com> wr=
ote:
> Cory,
>
> On Tue, Dec 7, 2010 at 10:49, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
>> On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.c=
om> wrote:
>
> <<snip>>
>
>>> @@ -1642,6 +1502,13 @@ static int gpio_debounce(struct gpio_chip *c=
hip, unsigned offset,
>>> =A0 =A0 =A0 =A0unsigned long flags;
>>>
>>> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
>>> +
>>> + =A0 =A0 =A0 if (!bank->dbck) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck =3D clk_get(bank->dev, "db=
clk");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "C=
ould not get gpio dbck\n");
>>> + =A0 =A0 =A0 }
>>> +
>>
>> I'm testing this on omap7xx, which doesn't have a dbclk. =A0Even wit=
h
>> dbck_flag set to false, this code still runs, causing these messages
>> to show up:
>
> Thanks for testing this series on OMAP7xx.
>
>>
>> =A0 =A0omap_gpio omap_gpio.5: Could not get gpio dbck
>> =A0 =A0omap_gpio omap_gpio.6: Could not get gpio dbck
>>
>> I think that 'if' should be:
>>
>> =A0 =A0if (bank->dbck_flag && !bank->dbck) {
>
> You are right. Will send a patch now.
>
>>
>> Also, see my comments in patch 4 - OMAP7xx: GPIO: Introduce support
>> for GPIO init, as there's dbck_flag entries there that are needed fo=
r
>> omap7xx. =A0Otherwise, seems to work well.

I noticed that gpio_debounce() calls _set_gpio_debounce() which is
handling only OMAP2+.
Hence I guess this should not be called for OMAP7xx at all. Now sure
how it was working earlier.

Anyways I can send the patch to fix the above mentioned warning.
Handling debounce feature
for OMAP1 needs to be fixed. I do not have a OMAP1 board here to fix
and verify the same.

>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
