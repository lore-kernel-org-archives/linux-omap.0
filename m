From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
Date: Mon, 11 Oct 2010 22:13:33 +0300
Message-ID: <AANLkTinFRnT9UrNfppG-P26DmfNPv413wBu39utMxred@mail.gmail.com>
References: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
	<1286790830-13505-2-git-send-email-felipe.contreras@gmail.com>
	<20101011.152822.226794892.Hiroshi.DOYU@nokia.com>
	<AANLkTikEC9yJuAZPr25+8F7Cggce3qO2b5aCz-7cQPd9@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2C14@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51679 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab0JKTNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 15:13:36 -0400
Received: by bwz15 with SMTP id 15so1907190bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 12:13:34 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2C14@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Marathe, Yogesh" <yogesh_marathe@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 11, 2010 at 6:54 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> Once the iommu migration works (haven't managed to get it
>> working myself), and it has been merged into mainline, then
>> we can think about enabling it unconditionally. In the
>> meantime, enabling unconditionally would break the
>> tidspbridge that is in staging (mainline).
>
> What is the problem enabling unconditionally?
>
> The iva2 iommu does not start working until you call iommu_get.
> So if for some reason you are using the dspbridge with custom
> Iommu implementation it should not cause any collision with
> Iommu module.

Read the code below (omap_iommu_init), the resources are registered so
nobody else can use them. This caused problems multiple times inside
Nokia, which is what motivated to write the patch in the first
place[1].

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=58305

-- 
Felipe Contreras
