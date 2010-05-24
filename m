From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 10/14] omap: mailbox: reorganize registering
Date: Mon, 24 May 2010 22:17:29 +0300
Message-ID: <AANLkTikNquOP901wjXup7K-5ea8OvgiRT9Vs7B8vR0jB@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	 <1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
	 <20100524.182407.67910029.Hiroshi.DOYU@nokia.com>
	 <20100524183249.GF21117@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61075 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab0EXTRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:17:30 -0400
Received: by bwz7 with SMTP id 7so1190338bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:17:29 -0700 (PDT)
In-Reply-To: <20100524183249.GF21117@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 24, 2010 at 9:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 24, 2010 at 06:24:07PM +0300, Hiroshi DOYU wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
>> Date: Sat, 22 May 2010 19:14:21 +0200
>>
>> > platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > - =C2=A0 if (unlikely(!res)) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "invalid =
mem resource\n");
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> > - =C2=A0 }
>> > + =C2=A0 res =3D pdev->resource;
>>
>> why not?
>>
>> =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_=
MEM, 0);
>
> I agree - always use the accessors provided rather than going beneath
> the covers and fiddling directly with stuff inside objects.

Yes, this patch slipped from the previous series where resources were
defined in the same file and some tricky assumptions were being made.
Now platform_get_resource() makes more sense.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
