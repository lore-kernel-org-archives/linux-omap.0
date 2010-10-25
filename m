From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v3 03/11] OMAP3: PM: Adding smartreflex driver support.
Date: Mon, 25 Oct 2010 14:12:08 +0300
Message-ID: <AANLkTim-xzAEHF_+D_P-w2gKczaPDhqw9z85xG+2G7a6@mail.gmail.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-4-git-send-email-thara@ti.com>
	<87lj61tzaz.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95E9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54275 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab0JYLMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 07:12:09 -0400
Received: by qyk12 with SMTP id 12so1381636qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Oct 2010 04:12:09 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95E9C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 if (ret) {
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *mem;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(sr_info->base);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem =3D platform_get_resourc=
e(sr_info->pdev,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IORESOURCE_M=
EM, 0);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(mem->star=
t, resource_size(mem));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&sr_info->node);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&sr_info->pdev->dev,=
 "%s: ERROR in registering"
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "interrupt h=
andler. Smartreflex will"
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not functio=
n as desired\n", __func__);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(sr_info);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>> + =A0 =A0 =A0 =A0 =A0 }
>>>
>>>and move this after the return...
>
> I did not understand this comment.

I guess he meant to move error handling to the end of function, and
jump there with goto.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
