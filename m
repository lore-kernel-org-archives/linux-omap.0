From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 15:52:58 +0530
Message-ID: <CAC83ZvLbLM1b=UpM8DeW4KvoGbtd7AG5a1PQeauD4m0RficKQg@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	<1340372890-10091-7-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1206221312400.10198@utopia.booyaka.com>
	<4FE7F765.40405@ti.com>
	<CAC83Zv+2B9=fu+YDab62O-WZdJzP8-qddPOZaVKLrqD0vvzCjw@mail.gmail.com>
	<4FE80D05.7010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41039 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189Ab2FYKW7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 06:22:59 -0400
Received: by qcmv28 with SMTP id v28so2359196qcm.25
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 03:22:58 -0700 (PDT)
In-Reply-To: <4FE80D05.7010305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Pankaj Jangra <jangra.pankaj9@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Jun 25, 2012 at 12:32 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Monday 25 June 2012 11:41 AM, DebBarma, Tarun Kanti wrote:
>>
>> On Mon, Jun 25, 2012 at 11:00 AM, Rajendra Nayak<rnayak@ti.com> =A0w=
rote:
>>>
>>> On Saturday 23 June 2012 12:47 AM, Paul Walmsley wrote:
>>>>
>>>>
>>>> Hi
>>>>
>>>> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>>>>
>>>>> In preparation of OMAP moving to Common Clk Framework(CCF) add
>>>>> clk_prepare()
>>>>> for omap gpio debounce clock.
>>>>>
>>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>>>> ---
>>>>> =A0drivers/gpio/gpio-omap.c | =A0 =A02 ++
>>>>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>> index c4ed172..6a73b01 100644
>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>> @@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *ch=
ip,
>>>>> unsigned offset,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->dbck =3D clk_get(bank->dev, =
"dbclk");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(bank->dbck))
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(bank->dev,=
 "Could not get gpio dbck\n");
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_prepare(bank->d=
bck);
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
>>>>
>>>>
>>>>
>>>> What code unprepares this clock?
>>>>
>>>> Put differently, doesn't this driver need at least a platform_driv=
er
>>>> .remove function pointer, that would call clk_unprepare() and clk_=
put()?
>>>
>>>
>>>
>>> Maybe because this driver can never be built as a module. It gets
>>> complied in with CONFIG_ARCH_OMAP=3Dy.
>>>
>>> Adding Tarun and Santosh who can comment further.
>>>
>>>
>>>>
>>>> Also, it looks to me that the bank->dbck init should be in
>>>> omap_gpio_chip_init(), not gpio_debounce()?
>>>
>>>
>>>
>>> Tarun, can you comment on why the dbck init is in gpio_debounce
>>> and not in omap_gpio_chip_init()?
>>
>> BTW, bank->dbck is initialized in gpio_debounce() even before the cl=
eanup
>> and fixes series. I am not quite sure if there was specific intent f=
or
>> keeping
>> it here. Personally I do not see issues in doing clk_get of bank->db=
ck in
>> omap_gpio_chip_init().
>
>
> Care to send a patch to move it into omap_gpio_chip_init() then? Also
> can you comment on the above point that Paul made, as to why this dri=
ver
> has a .remove missing? If adding that is a non-issue, would be great =
if
> you can drop in a patch for that too.
Yes, I will have a re-look before generating the patches.
--
Tarun
>>>>
>>>>
>>>> - Paul
>>>
>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
