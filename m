From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 23:26:04 +0200
Message-ID: <AANLkTimmd=jKk_x4DNao_NG9dEiQtQvOQ=TePn-Dgc_b@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
	<AANLkTikMjAh+LAFaWELyiJc+ou+N8v_7xhrwHRbBZZQF@mail.gmail.com>
	<20101109173536.GE9264@atomide.com>
	<AANLkTinLORQ7Hyn7nqkNZhRbP8iTGRfAXibgY2VeZTPq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinLORQ7Hyn7nqkNZhRbP8iTGRfAXibgY2VeZTPq@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 9, 2010 at 7:52 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Tue, Nov 9, 2010 at 11:35 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> * Guzman Lugo, Fernando <fernando.lugo@ti.com> [101109 08:36]:
>>>
>>> tidspbridge iommu change are working fine all the patches and few f=
ixes after
>>> that are alredy sent. what breaks tidspbridge, is the unmerged
>>> dependencies in linux omap tree, specifically the iommu module patc=
hes
>>> and the SG patch.
>>
>> Care to post a series of the missing patches listed above?
>
> Here are the missing patches:
>
> Fernando Guzman Lugo (4):
> =C2=A0iovmm: no gap checking for fixed address
> =C2=A0iovmm: add superpages support to fixed da address
> =C2=A0iovmm: replace __iounmap with omap_iounmap
> =C2=A0iommu: create new api to set valid da range
>
> and
> =C2=A0scatterlist: define SG chain for arm architecture

Those are not the only patches needed, you would also need:
 omap: iommu: make iva2 iommu selectable
 staging: tidspbridge: enable iva2 iommu

And the one that actually uses the new API for the da range which
hasn't even been submitted to the mailing list.

Personally, I haven't seen the new iommu code working correctly.

--=20
=46elipe Contreras
