From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Tue, 8 Mar 2011 11:15:22 +0530
Message-ID: <AANLkTinCejzMVvNy9i8LHpAFofhpXSJ4wqJdDGtapp3P@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-3-git-send-email-charu@ti.com> <8762ryftbs.fsf@ti.com>
 <AANLkTikziwQBwPVOMxbQaTj5Oa-UAc38Eb87jq_QAHSD@mail.gmail.com>
 <87k4ga7o9b.fsf@ti.com> <alpine.DEB.2.00.1103071635410.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45889 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1CHFqE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 00:46:04 -0500
Received: by fxm20 with SMTP id 20so7139820fxm.40
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 21:46:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103071635410.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

Paul, Kevin,

Thanks.

On Tue, Mar 8, 2011 at 07:55, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Mon, 7 Mar 2011, Kevin Hilman wrote:
>
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>>
>> > On Sat, Mar 5, 2011 at 02:21, Kevin Hilman <khilman@ti.com> wrote:
>> >> Charulatha V <charu@ti.com> writes:
>> >>>
>> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bank->pwrdm_name, "wkup_pw=
rdm"))
>> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> >>> +
>> >>
>> >> This adds a string compare for every bank during every idle
>> >> transistion (and every resume.) =A0That's a lot of unneeded overh=
ead.
>> >>
>> >> I'd rather see a per-bank flag 'looses_context' or something that=
 can be
>> >> checked more efficiently in this fast path. =A0This flag can be s=
et based
>> >> on the powerdomain name in the device init code.
>> >
>> > This looks better. Will do the needful.
>> > One question, can "looses_context" be made as part of dev_attr?
>>
>> I guess that's up to Beno=EEt.
>>
>> But, I don't think that's necessary. It should be easy to set at run=
time
>> just doing a strcmp on the powerdomain during the device init,
>> omap_device_build phase.
>
> It shouldn't be part of .dev_attr, since it's not a IP block-specific
> attribute, it's a powerdomain-specific attribute. =A0The same hwmod
> structure might be used on another OMAP chip that places the device i=
n a
> different powerdomain.
>
> It would also be good to avoid doing strcmp()s here. =A0The powerdoma=
in name
> string, like any name string, should basically be opaque to code.
>
> In this case, the best approach is probably for the subarch integrati=
on
> code to ask the powerdomain code whether the hwmod's powerdomain can =
ever
> lose context. =A0I just posted a patch series to do this[1], so I'd s=
uggest
> you use the function that it exports.

Will do the needful.
- V Charulatha

>
>
> - Paul
>
> 1. http://marc.info/?l=3Dlinux-omap&m=3D129955064112024&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
