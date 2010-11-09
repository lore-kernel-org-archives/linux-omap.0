From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 11:04:18 -0600
Message-ID: <AANLkTinFW431t9XFqHc=wZAws9gjT0ikrc03J83kH7iF@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
	<20101109165509.GA9698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39716 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213Ab0KIREk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 12:04:40 -0500
In-Reply-To: <20101109165509.GA9698@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 9, 2010 at 10:55 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 09, 2010 at 05:29:17PM +0100, Arnd Bergmann wrote:
>> On Tuesday 09 November 2010, Felipe Contreras wrote:
>> > Felipe Contreras (14):
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - update Kconfig to selec=
t IOMMU module"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove dmm custom modul=
e"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - deprecate reserve/unres=
erve_memory funtions"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove reserved memory =
clean up"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge: remove dw_dmmu_base from=
 cfg_hostres struct"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - move all iommu related =
code to a new file"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove hw directory"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - fix mmufault support"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove custom mmu code =
from tiomap3430.c"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - rename bridge_brd_mem_m=
ap/unmap to a proper name"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge - move shared memory iomm=
u maps to tiomap3430.c"
>> > =A0 =A0 =A0 Revert "staging: tidspbridge: replace iommu custom for=
 opensource implementation"
>>
>> That adds quite a lot of crap back in that was removed by Fernando e=
arlier:
>>
>> =A044 files changed, 3733 insertions(+), 847 deletions(-)
>>
>> It may have been premature to merge the patches as you say, but now =
that
>> they are in, I'd vote for giving Fernando a chance to fix up any dam=
age
>> that was done in the process rather than just reverting all the usef=
ul
>> changes.
>
> In looking at this further, I agree.
>
> Felipe, are all of these really needing to be reverted? =A0How about
> picking out the functional changes that need to be resolved instead o=
f
> just rolling back everything that has been done here. =A0Surely not a=
ll of
> these are wrong, right?

Patches are _NOT_ wrong, missing dependencies break the bridge.
Without that dependencies the first patch of the set won't work and
all other patches have dependency on the first one, so all of them
need to be reverted.

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
