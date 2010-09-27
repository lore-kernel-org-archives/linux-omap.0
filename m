From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Mon, 27 Sep 2010 22:42:21 +0300
Message-ID: <AANLkTikWJ-n708ou_BkVchCvk025GVo-Ljq+CHe4T5vT@mail.gmail.com>
References: <1285529740-28232-1-git-send-email-notasas@gmail.com>
	<AANLkTinkxokX9BGtxysYOr19xbZR4S8oPRYUAyneutzc@mail.gmail.com>
	<AANLkTinh+JTwyE4E33QXdnZ8obYA8S0SU71i3kGi=wRT@mail.gmail.com>
	<AANLkTik0LOQN8kOPjv_VohhO5To6pZDS=M0mw=q0whPp@mail.gmail.com>
	<AANLkTi=xS_=QytU0Yrh5EEiiL6GyekcO+DezjT-Zpj-7@mail.gmail.com>
	<AANLkTi=gsvcWJak88NOfMjTumtLcdcU6-RUE+obWcacz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=gsvcWJak88NOfMjTumtLcdcU6-RUE+obWcacz@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Murthy <arunrmurthy.83@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Madhusudhan <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

>>> How do I get notified if battery voltage is low and needs charging
>>> from user space?
>>
>> Either additional monitoring chip notifies you (if you are lucky and
>> have one), or wait for update of this driver :) There are efforts to
>> merge MADC driver [1], but it may take some time.
> But using MADC, I can get the battery voltage and by means of
> monitoring battery voltage we can get to know low battery
> notification.

True, but let's wait for MADC driver to be merged for that first.

>>
>> [1] http://marc.info/?t=128461535700002&r=1&w=2
>>
> Thanks and Regards,
> Arun R Murthy
> --------------------
>
