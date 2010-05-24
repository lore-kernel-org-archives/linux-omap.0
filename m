From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 11/14] omap: mailbox: only compile for configured archs
Date: Mon, 24 May 2010 22:29:01 +0300
Message-ID: <AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	 <1274548465-20208-12-git-send-email-felipe.contreras@gmail.com>
	 <20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33269 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0EXT3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:29:03 -0400
Received: by bwz7 with SMTP id 7so1197482bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:29:01 -0700 (PDT)
In-Reply-To: <20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>

>> +     if (false);
>
> nitpcik:
> The above may look better as below:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (false)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;
>
> "checkpatch.pl" also doesn't complain.

Personally I think it looks weird and it's a checkpatch bug, but fine b=
y me.

>> +#if defined(CONFIG_ARCH_OMAP3430)
>> + =C2=A0 =C2=A0 else if (cpu_is_omap3430()) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D omap3_mbox=
es;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[0]->irq =3D pl=
atform_get_irq_byname(pdev, "dsp");
>> =C2=A0 =C2=A0 =C2=A0 }
>> +#endif
>> =C2=A0#if defined(CONFIG_ARCH_OMAP2420)
>> =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_omap2420()) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D omap2_mbox=
es;
>> @@ -407,12 +415,14 @@ static int __devinit omap2_mbox_probe(struct p=
latform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[1]->irq =3D pl=
atform_get_irq_byname(pdev, "iva");
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0#endif
>> +#if defined(CONFIG_ARCH_OMAP4)
>> =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_omap44xx()) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D omap4_mbox=
es;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[0]->irq =3D li=
st[1]->irq =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 platform_get_irq_byname(pdev, "mbox");
>
> For checkpatch.pl,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list[0]->irq =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0platform_get_irq_byname(pdev, "mbox");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list[1]->irq =3D=
 list[0]->irq;

I don't see checkpatch (0.30) complaining about that.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
