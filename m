From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in board_init
Date: Tue, 25 Jan 2011 12:20:16 +0530
Message-ID: <AANLkTikg=keTxGpYKR8K+F60Rjzv7xuNY56ocWxMC6pw@mail.gmail.com>
References: <hvaibhav@ti.com> <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
 <AANLkTikcTqXS3vSSnmiS94SAHbAm-NPbT-_BTExDwvr-@mail.gmail.com> <19F8576C6E063C45BE387C64729E739404BD65F509@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56800 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464Ab1AYGu5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 01:50:57 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so1755500yxd.6
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 22:50:56 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD65F509@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>

<<snip>>

Missed this one in the previous threads.

>> > +
>> > =A0 =A0 =A0 =A0eth_cs =3D OMAP3EVM_SMSC911X_CS;
>> >
>> > =A0 =A0 =A0 =A0l3ck =3D clk_get(NULL, "l3_ck");
>> > @@ -136,6 +141,22 @@ static inline void __init
>> omap3evm_init_smsc911x(void)
>> > =A0 =A0 =A0 =A0else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_get_rate(l3ck);
>> >
>> > + =A0 =A0 =A0 /* Configure ethernet controller reset gpio */
>> > + =A0 =A0 =A0 if (cpu_is_omap3430()) {
>>
>> cpu_is_omap3430() is not required, as this board init would not be
>> called otherwise.
> [Hiremath, Vaibhav] That is not quite true, why do you say this?

The board file init means that the cpu info is already identified.
Do you think that omap3evm_init_smsc911x() would be called for
other than OMAP3430?

>
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_request(eth_rst, "SMSC911x =
gpio") < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN_ERR "Fai=
led to request GPIO7 for
>> smsc911x\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(eth_rst, 1);
>>

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
