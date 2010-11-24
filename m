From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Wed, 24 Nov 2010 07:22:07 -0600
Message-ID: <AANLkTi=d5d5OQEY0AMEvfQh_KOnMsZrHpWizBoa=fBEX@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
	<AANLkTi=tzuzOMa6kPp-a6+yn6xMLGtdVSvAxPFP5RU5q@mail.gmail.com>
	<AANLkTin8kxk=R5xQyp-ZcKVr-0eiM82L=QcF1PC2g-5n@mail.gmail.com>
	<AANLkTikD20HGY+9BqBKX0DwFW7wPDTvt=wZqyAcHwckk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48738 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab0KXNWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 08:22:08 -0500
Received: by mail-qw0-f52.google.com with SMTP id 4so13733qwe.11
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 05:22:08 -0800 (PST)
In-Reply-To: <AANLkTikD20HGY+9BqBKX0DwFW7wPDTvt=wZqyAcHwckk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

On Wed, Nov 24, 2010 at 7:12 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> On Wed, Nov 24, 2010 at 18:39, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
>> On Tue, Nov 23, 2010 at 11:29 PM, Varadarajan, Charulatha <charu@ti.=
com> wrote:
>>> On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> w=
rote:
>>>> In the current mailbox driver, the mailbox internal pointer for
>>>> callback can be directly manipulated by the Users, so a second
>>>> User can easily corrupt the first user's callback pointer.
>>>> The initial effort to correct this issue can be referred here:
>>>> https://patchwork.kernel.org/patch/107520/
>>>>
>>>> Along with fixing the above stated issue, this patch =A0adds the
>>>> flexibility option to register notifications from
>>>> multiple readers to the events received on a mailbox instance.
>>>> The discussion regarding this can be referred here.
>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30671.ht=
ml
>>>>
>>>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>>>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>>>> ---
>>>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A07 +-
>>>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A010=
4 ++++++++++++++++-------------
>>>> =A02 files changed, 62 insertions(+), 49 deletions(-)
>>>>
>>>
>>> <<snip>>
>>>
>>>> @@ -363,10 +372,13 @@ int omap_mbox_register(struct device *parent=
, struct omap_mbox **list)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbo=
x->dev);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>> +
>>>
>>> Do this change in the patch where the below code was added.
>>
>> I am sorry I didn't get you. you mean BLOCKING_INIT_NOTIFIER_HEAD li=
ne
>> ? yes, it is needed for this patch.
>
> No. I was saying that adding a new line could be done in the patch wh=
ere this
> piece of code (below 4 lines) was introduced. Sorry if that was not c=
lear :-(

Got it. extra line can be removed.

Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
