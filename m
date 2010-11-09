From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 10:46:02 -0600
Message-ID: <AANLkTikMjAh+LAFaWELyiJc+ou+N8v_7xhrwHRbBZZQF@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201011091729.17679.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 9, 2010 at 10:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 November 2010, Felipe Contreras wrote:
>> Felipe Contreras (14):
>> =A0 =A0 =A0 Revert "staging: tidspbridge - update Kconfig to select =
IOMMU module"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - remove dmm custom module"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - deprecate reserve/unreser=
ve_memory funtions"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - remove reserved memory cl=
ean up"
>> =A0 =A0 =A0 Revert "staging: tidspbridge: remove dw_dmmu_base from c=
fg_hostres struct"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - move all iommu related co=
de to a new file"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - remove hw directory"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - fix mmufault support"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - remove custom mmu code fr=
om tiomap3430.c"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - rename bridge_brd_mem_map=
/unmap to a proper name"
>> =A0 =A0 =A0 Revert "staging: tidspbridge - move shared memory iommu =
maps to tiomap3430.c"
>> =A0 =A0 =A0 Revert "staging: tidspbridge: replace iommu custom for o=
pensource implementation"
>
> That adds quite a lot of crap back in that was removed by Fernando ea=
rlier:
>
> =A044 files changed, 3733 insertions(+), 847 deletions(-)
>
> It may have been premature to merge the patches as you say, but now t=
hat
> they are in, I'd vote for giving Fernando a chance to fix up any dama=
ge
> that was done in the process rather than just reverting all the usefu=
l
> changes.
>
> =A0 =A0 =A0 =A0Arnd

tidspbridge iommu change are working fine all the patches and few fixes=
 after
that are alredy sent. what breaks tidspbridge, is the unmerged
dependencies in linux omap
tree, specifically the iommu module patches and the SG patch. if the
dependencies are merged tidspbridge work perfectly I don't need to fix
anything. As the dependencies are not merge yet it is ok to revert and
once push once all the dependencies are merge. I am not familiar with
that so I don't know how much time can it take.

Regards,
=46ernando.

>
