From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Fri, 19 Nov 2010 08:22:10 -0600
Message-ID: <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59120 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752918Ab0KSOWL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 09:22:11 -0500
Received: by mail-qy0-f174.google.com with SMTP id 32so69748qyk.5
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 06:22:10 -0800 (PST)
In-Reply-To: <20101119083250.GH6446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

=46elipe,

On Fri, Nov 19, 2010 at 2:32 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Nov 18, 2010 at 06:07:40PM -0600, Kanigeri, Hari wrote:
>>
>> Benoit,
>>
>> On Thu, Nov 18, 2010 at 5:28 PM, Cousson, Benoit <b-cousson@ti.com> =
wrote:
>>>
>>> On 11/18/2010 8:15 PM, Hari Kanigeri wrote:
>>>>
>>>> disabling rx interrupt on omap4 is different than its pre-decessor=
s.
>>>> The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable th=
e
>>>> interrupts instead of clearing the bit.
>>>>
>>>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/mailbox.c | =A0 =A05 ++++-
>>>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/mailbox.c
>>>> b/arch/arm/mach-omap2/mailbox.c
>>>> index 42dbfa4..82b5ced 100644
>>>> --- a/arch/arm/mach-omap2/mailbox.c
>>>> +++ b/arch/arm/mach-omap2/mailbox.c
>>>> @@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct oma=
p_mbox
>>>> *mbox,
>>>> =A0 =A0 =A0 =A0struct omap_mbox2_priv *p =3D (struct omap_mbox2_pr=
iv *)mbox->priv;
>>>> =A0 =A0 =A0 =A0u32 l, bit =3D (irq =3D=3D IRQ_TX) ? p->notfull_bit=
 : p->newmsg_bit;
>>>> =A0 =A0 =A0 =A0l =3D mbox_read_reg(p->irqdisable);
>>>> - =A0 =A0 =A0 l&=3D ~bit;
>>>> + =A0 =A0 =A0 if (cpu_is_omap44xx())
>>>
>>> Since it is not omap version specific but IP version specific, you =
should
>>> not use cpu_is_ to do that. Moreover cpu_is calls should be used du=
ring
>>> init
>>> only.
>>> You can use the rev field in hwmod_class in order to detect the IP
>>> version.
>>> Smartreflex series for 3630 is already using that kind of mechanism=
=2E
>>> You will have to copy that revision information into pdata struct a=
nd
>>> then
>>> use that here.
>>
>> I see your point, but since mailbox hwmod patches from Omar are stil=
l
>> under review I didn't find any other option than to enable this
>> This is critical functionality that I want to include in and not wai=
t
>> till the hwmod patches are accepted.
>> Please let me know if there is any other way of approaching this pro=
blem ?
>
> how about you read the IP revision yourself during probe ? Or pass in=
 a
> flag like I said on the other email ?
>

I like your proposal of reading the IP revision in probe. I will send
a revised patch for this.

Benoit, is this ok until we move to hwmod implemenation ?


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
