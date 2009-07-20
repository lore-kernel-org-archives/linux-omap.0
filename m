From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 9/10] drivers/mmc: Move a dereference below a NULL test
Date: Mon, 20 Jul 2009 15:43:07 +0300
Message-ID: <4A64665B.9000504@nokia.com>
References: <Pine.LNX.4.64.0907191729580.16542@ask.diku.dk>	 <4A642458.6080008@nokia.com> <c656a4d20907200533t1cbe1476l62d8a51fdb796c70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30614 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbZGTMmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 08:42:39 -0400
In-Reply-To: <c656a4d20907200533t1cbe1476l62d8a51fdb796c70@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

arun c wrote:
> On Mon, Jul 20, 2009 at 1:31 PM, Adrian Hunter<adrian.hunter@nokia.com> wrote:
>> Julia Lawall wrote:
>>> From: Julia Lawall <julia@diku.dk>
>>>
>>> If the NULL test is necessary, then the dereference should be moved below
>>> the NULL test.
>>>
>>> The semantic patch that makes this change is as follows:
>>> (http://www.emn.fr/x-info/coccinelle/)
>>>
>>> // <smpl>
>>> @@
>>> type T;
>>> expression E,E1;
>>> identifier i,fld;
>>> statement S;
>>> @@
>>>
>>> - T i = E->fld;
>>> + T i;
>>>  ... when != E=E1
>>>      when != i
>>>  BUG_ON (E == NULL||
>>> -     i
>>> +     E->fld
>>>       == NULL || ...);
>>> + i = E->fld;
>>> // </smpl>
>>>
>>> Signed-off-by: Julia Lawall <julia@diku.dk>
>>>
>>> ---
>>>  drivers/mmc/host/omap.c             |    5 +++--
>>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>>> index e7a331d..89281ab 100644
>>> --- a/drivers/mmc/host/omap.c
>>> +++ b/drivers/mmc/host/omap.c
>>> @@ -255,11 +255,12 @@ static void mmc_omap_slot_release_work(struct
>>> work_struct *work)
>>>   static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int
>>> clk_enabled)
>>>  {
>>> -       struct mmc_omap_host *host = slot->host;
>>> +       struct mmc_omap_host *host;
>>>        unsigned long flags;
>>>        int i;
>>>  -       BUG_ON(slot == NULL || host->mmc == NULL);
>>> +       BUG_ON(slot == NULL || slot->host->mmc == NULL);
>>> +       host = slot->host;
>>>          if (clk_enabled)
>>>                /* Keeps clock running for at least 8 cycles on valid freq
>>> */
>>> --
>> If slot is NULL it will oops anyway, so the following is better IMHO:
>>
>> static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int
>> clk_enabled)
>> {
>>        struct mmc_omap_host *host = slot->host;
>>        unsigned long flags;
>>        int i;
>>
>>> -       BUG_ON(slot == NULL || host->mmc == NULL);
>>> +       BUG_ON(host->mmc == NULL);
>>        if (clk_enabled)
>>                /* Keeps clock running for at least 8 cycles on valid freq */
>> --
> 
> According to http://isc.sans.org/diary.html?storyid=6820&rss "NULL check"
> must be done before assigning the values. Does Julia Lawall's version
> is the more correct one??
> 
> Arun

It is not a "NULL check" it is an assertion, which can be compiled out.
On some platforms BUG is implemented as a null dereference anyway
e.g. on ARM  it is *(int *)0 = 0;

