From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v9 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
Date: Mon, 24 Jan 2011 11:20:57 +0530
Message-ID: <AANLkTi=zrLh5kaFUOsJvc1jyD5kcgw9NBRoT2zjB=2jy@mail.gmail.com>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com>
 <1295690758-5845-19-git-send-email-sumit.semwal@ti.com> <4D3C217B.9020301@ru.mvista.com>
 <20110123125216.GA29926@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60620 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab1AXFvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 00:51:20 -0500
Received: by bwz5 with SMTP id 5so3218908bwz.8
        for <linux-omap@vger.kernel.org>; Sun, 23 Jan 2011 21:51:17 -0800 (PST)
In-Reply-To: <20110123125216.GA29926@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, khilman@ti.com, paul@pwsan.com, Senthilvadivu Guruswamy <svadivu@ti.com>, hvaibhav@ti.com, tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jan 23, 2011 at 6:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 23, 2011 at 03:39:23PM +0300, Sergei Shtylyov wrote:
>>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/ds=
s/dss.c
>>> index 4d7a816..22690e9 100644
>>> --- a/drivers/video/omap2/dss/dss.c
>>> +++ b/drivers/video/omap2/dss/dss.c
>> [...]
>>> @@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
>>> =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, 0, 2, 2); =A0 =A0 =A0/* venc cl=
ock mode =3D normal */
>>> =A0 #endif
>>>
>>> - =A0 =A0r =3D request_irq(INT_24XX_DSS_IRQ,
>>> + =A0 =A0dss_irq =3D platform_get_irq(dss.pdev, 0);
>>> + =A0 =A0if (dss_irq !=3D -ENXIO) {
>>
>> =A0 =A0Better just 'dss_irq > 0', IMHO.
>
> If a function returns negative error codes, the correct test is
> =A0 =A0 =A0 =A0ret < 0
> not
> =A0 =A0 =A0 =A0ret <=3D 0
>
> The fact that it happens to be dealing with IRQ numbers where IRQ0
> may not be valid is neither here nor there.
>
Thanks Sergei, Russell,

I will update this to check for (ret < 0) as the error case, and re-sub=
mit.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
