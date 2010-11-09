From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 11:49:30 -0600
Message-ID: <AANLkTi=CKERMcSLXwQa7G55P69DO--UPN9HgOScHP_yO@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
	<20101109165509.GA9698@kroah.com>
	<AANLkTinFW431t9XFqHc=wZAws9gjT0ikrc03J83kH7iF@mail.gmail.com>
	<20101109172511.GA10958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44841 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754131Ab0KIRtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 12:49:39 -0500
In-Reply-To: <20101109172511.GA10958@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 9, 2010 at 11:25 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 09, 2010 at 11:04:18AM -0600, Guzman Lugo, Fernando wrote=
:
>> On Tue, Nov 9, 2010 at 10:55 AM, Greg KH <greg@kroah.com> wrote:
>> > On Tue, Nov 09, 2010 at 05:29:17PM +0100, Arnd Bergmann wrote:
>> >> On Tuesday 09 November 2010, Felipe Contreras wrote:
>> >> > Felipe Contreras (14):
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - update Kconfig to se=
lect IOMMU module"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove dmm custom mo=
dule"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - deprecate reserve/un=
reserve_memory funtions"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove reserved memo=
ry clean up"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge: remove dw_dmmu_base f=
rom cfg_hostres struct"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - move all iommu relat=
ed code to a new file"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove hw directory"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - fix mmufault support=
"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove custom mmu co=
de from tiomap3430.c"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - rename bridge_brd_me=
m_map/unmap to a proper name"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - move shared memory i=
ommu maps to tiomap3430.c"
>> >> > =A0 =A0 =A0 Revert "staging: tidspbridge: replace iommu custom =
for opensource implementation"
>> >>
>> >> That adds quite a lot of crap back in that was removed by Fernand=
o earlier:
>> >>
>> >> =A044 files changed, 3733 insertions(+), 847 deletions(-)
>> >>
>> >> It may have been premature to merge the patches as you say, but n=
ow that
>> >> they are in, I'd vote for giving Fernando a chance to fix up any =
damage
>> >> that was done in the process rather than just reverting all the u=
seful
>> >> changes.
>> >
>> > In looking at this further, I agree.
>> >
>> > Felipe, are all of these really needing to be reverted? =A0How abo=
ut
>> > picking out the functional changes that need to be resolved instea=
d of
>> > just rolling back everything that has been done here. =A0Surely no=
t all of
>> > these are wrong, right?
>>
>> Patches are _NOT_ wrong, missing dependencies break the bridge.
>> Without that dependencies the first patch of the set won't work and
>> all other patches have dependency on the first one, so all of them
>> need to be reverted.
>
> How about hand-reverting only the wrong patch, so the other work isn'=
t
> lost? =A0I'd much prefer that.

Unfortunately any of the iommu migration patches will work correctly
without the dependencies on iommu module patches. There are some
patches which cleanup the code, but thanks to the iommu migrations the
files can disappear complete other wise I need to check and only clean
what is not needed and leave what the old custom implementation is
using, which will need a lot of rework in the patches. According with
=46elipe Contreras it is very easy reverting and pushing after. I don't
like the idea of reverting all iommu patches, however looks the
easiest solution. Unless the dependencies patches can be merged the
would be the best solution.

Regards,
=46ernando.

>
> thanks,
>
> greg k-h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
