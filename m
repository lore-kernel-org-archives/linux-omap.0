From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
Date: Mon, 11 Oct 2010 16:00:26 +0300
Message-ID: <AANLkTikEC9yJuAZPr25+8F7Cggce3qO2b5aCz-7cQPd9@mail.gmail.com>
References: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
	<1286790830-13505-2-git-send-email-felipe.contreras@gmail.com>
	<20101011.152822.226794892.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55304 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab0JKNA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 09:00:27 -0400
Received: by bwz15 with SMTP id 15so1652116bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 06:00:26 -0700 (PDT)
In-Reply-To: <20101011.152822.226794892.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, greg@kroah.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, yogesh_marathe@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, Oct 11, 2010 at 3:28 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
> Date: Mon, 11 Oct 2010 11:53:49 +0200
>
>> From: Felipe Contreras <felipe.contreras@nokia.com>
>>
>> It seems dsp-link will do this, and tidspbridge too at some point, but
>> right now it's not possible to select CONFIG_MPU_BRIDGE_IOMMU.
>
> Why does it have to be selectable?

You mean why is it desirable to turn it off? Right now there's a mess
of tidspbridge branches, some work, some don't, some have migrated to
iommu, some don't. In mainline all this, plus the status on dsp-link,
should be irrelevant, a configuration solves all the issues.

Once the iommu migration works (haven't managed to get it working
myself), and it has been merged into mainline, then we can think about
enabling it unconditionally. In the meantime, enabling unconditionally
would break the tidspbridge that is in staging (mainline).

> Please Cc: linux-arm-kernel@lists.infradead.org too.

Will do, after you reply the above.

-- 
Felipe Contreras
