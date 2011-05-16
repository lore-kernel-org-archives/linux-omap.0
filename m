From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [patch v4 3/3] arm: omap4: support pmu
Date: Mon, 16 May 2011 09:28:02 +0800
Message-ID: <BANLkTi==6gmitMOFuRP2DV7XB6MeippCyA@mail.gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
	<BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
	<1305468960.2848.2.camel@jazzbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62780 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab1EPB2E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 May 2011 21:28:04 -0400
Received: by gxk21 with SMTP id 21so1374759gxk.19
        for <linux-omap@vger.kernel.org>; Sun, 15 May 2011 18:28:03 -0700 (PDT)
In-Reply-To: <1305468960.2848.2.camel@jazzbox>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Rabin Vincent <rabin@rab.in>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, linux-arm-kernel@lists.infradead.org, avik.sil@linaro.org

Hi,

2011/5/15 Will Deacon <will.deacon@arm.com>:
> [Adding Avik],
>
>
> On Sat, 2011-05-14 at 09:48 +0100, Ming Lei wrote:
>> Hi Rabin,
>>
>> 2011/5/14 Rabin Vincent <rabin@rab.in>:
>> > What happened to this patch? =A0It is neither in mainline nor in
>> > linux-next.
>> >
>>
>> This patch depends on the two with titles:
>>
>> =A0 =A0 =A0 introduce cross trigger interface helpers
>> =A0 =A0 =A0 pmu: allow platform specific irq enable/disable handling
>>
>> and the above patches have been submitted to RMK's patch system
>> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rm=
k,
>> so I can't ask omap guys to merge this one into their tree now.
>
> I don't think that Avik's problem with this patch has been fully
> addressed yet:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/0468=
99.html
>
> So regardless of the state of -next, I think there's still some more
> work to do on this code before it can go upstream.

I remembered that Avik reported his issue on linaro kernel, instead of =
mainline.
If Avik can reproduce this issue on mainline plus pandaboard, we can he=
lp to
do it. In fact, this issue is not reproduced at all in mainline on my
pandaboard.

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
