From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
Date: Mon, 3 May 2010 22:22:30 +0300
Message-ID: <n2z94a0d4531005031222t10ea8b8dm3de50b83936fafac@mail.gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
	 <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
	 <r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:54008 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab0ECTWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 15:22:31 -0400
Received: by ewy22 with SMTP id 22so839574ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 12:22:30 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Mon, May 3, 2010 at 9:50 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wro=
te:
>> > Small suggestion...if we are re-organizing can we make it look sim=
ilar
>> to how iommu is structured? This way we can maintain consistency.
>>
>> I thought I did. What exactly do you have in mind?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A01. What Tony mentioned in another email ab=
out using #ifdefs for the platforms. That will be bring close to what i=
s in omap-iommu.c
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A02. Compare iommu_get with mailbox_get. iom=
mu_get uses driver_find_device to get the iommu structure. I guess we c=
an apply the same logic to get mailbox structure. This way we can get r=
id of omap_mbox_register, omap_mbox_unregister, and find_mboxes functio=
ns.

As I mentioned in another thread[1], we can't really do that because
the mailboxes are not really separate devices, but different irqs of
the same device. They all share the same resources (mem, and even
irqs), so effectively they are all one device.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/34921

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
