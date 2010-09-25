From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
Date: Sat, 25 Sep 2010 18:42:33 +0300
Message-ID: <AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63921 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab0IYPmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 11:42:35 -0400
Received: by bwz11 with SMTP id 11so2536136bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Sep 2010 08:42:34 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Marathe, Yogesh" <yogesh_marathe@ti.com>

On Fri, Sep 24, 2010 at 6:17 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren
>> <tony@atomide.com> wrote:
>> > From: Yogesh Marathe <yogesh_marathe@ti.com>
>> >
>> > The definition of "iva2" device in iommu_device
>> > is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
>> > this option is not defined in KConfig.
>> >
>> > This patch removes the wrapper and makes "iva2"
>> > available as another iommu_device.
>>
>> NAK.
>>
>> This would break tidspbridge's MMU. This was discussed before:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=3D5=
8305
>>
>> When tidspbridge has migrated to iommu, then it should define
>> CONFIG_MPU_BRIDGE_IOMMU.
>
> =C2=A0Can you go through earlier discussion on this patch
> =C2=A0http://marc.info/?l=3Dlinux-omap&m=3D127979007623260&w=3D2
>
> =C2=A0I believe these concerns were discussed. I am unable to
> =C2=A0open the gmane thread (getting 504) - so can't be sure
> =C2=A0if Hiroshi had referred to same discussion.

When you merge iommu support, then either you enable
CONFIG_MPU_BRIDGE_IOMMU unconditionally, or you apply this patch, but
this patch alone will only break things.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
