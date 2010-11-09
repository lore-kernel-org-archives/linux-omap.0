From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Wed, 10 Nov 2010 00:04:58 +0200
Message-ID: <AANLkTikK=Vr4PkQYzBqS97beuZbTUWq5Xp=7=Uw6QcCn@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57442 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab0KIWE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 17:04:59 -0500
In-Reply-To: <201011091729.17679.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 9, 2010 at 6:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 November 2010, Felipe Contreras wrote:
>> Felipe Contreras (14):
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - update Kconfig t=
o select IOMMU module"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - remove dmm custo=
m module"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - deprecate reserv=
e/unreserve_memory funtions"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - remove reserved =
memory clean up"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge: remove dw_dmmu_ba=
se from cfg_hostres struct"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - move all iommu r=
elated code to a new file"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - remove hw direct=
ory"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - fix mmufault sup=
port"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - remove custom mm=
u code from tiomap3430.c"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - rename bridge_br=
d_mem_map/unmap to a proper name"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge - move shared memo=
ry iommu maps to tiomap3430.c"
>> =C2=A0 =C2=A0 =C2=A0 Revert "staging: tidspbridge: replace iommu cus=
tom for opensource implementation"
>
> That adds quite a lot of crap back in that was removed by Fernando ea=
rlier:
>
> =C2=A044 files changed, 3733 insertions(+), 847 deletions(-)
>
> It may have been premature to merge the patches as you say, but now t=
hat
> they are in, I'd vote for giving Fernando a chance to fix up any dama=
ge
> that was done in the process rather than just reverting all the usefu=
l
> changes.

The changes from Fernando require changes in other trees: arm, omap.
These cannot get into 2.6.37, and I have my doubts they would get into
2.6.38, as I haven't seen those ack'ed yet.

Moreover, I have applied all the patches Fernando has sent, and I
still haven't seen this driver working with the new iommu code.

So, sure, these patches are good, we (Nokia), requested them years
ago, but right now there's no way to get this driver working with them
on 2.6.37. I would rather have a working driver for once on a vanilla
kernel. It is really tiring to point people to different places to get
working code depending on which week they ask.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
