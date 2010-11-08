From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Tue, 9 Nov 2010 00:56:38 +0200
Message-ID: <AANLkTimNZKVPuHpyLb58r+fNyggdK5HqVhc_ZwAs9=o9@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
	<20101107220213.GB21070@kroah.com>
	<AANLkTin=reP=SJvo19=bPjYY2Owxa7a9EPKk-Jui97B4@mail.gmail.com>
	<20101108164538.GJ9264@atomide.com>
	<20101108191648.GR9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56155 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab0KHW4j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 17:56:39 -0500
Received: by bwz15 with SMTP id 15so476290bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 14:56:38 -0800 (PST)
In-Reply-To: <20101108191648.GR9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg KH <greg@kroah.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Mon, Nov 8, 2010 at 9:16 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [101108 08:37]:
>> * Felipe Contreras <felipe.contreras@gmail.com> [101107 14:38]:
>>
>> Thanks for putting together all these patches, that already helps
>> people working on it a great deal.
>>
>> However, these patches are in the no-no category for -rc cycle, they=
're
>> in the "fixes for features that never worked in the first place"
>> category. Linus will not take it and I don't want to take it. We jus=
t
>> have to follow the standard Linux development cycle.
>>
>> > Anyway, there's an alternative that doesn't require omap to ack:
>> >
>> > --- a/drivers/staging/tidspbridge/core/tiomap3430.c
>> > +++ b/drivers/staging/tidspbridge/core/tiomap3430.c
>> > @@ -23,7 +23,6 @@
>> > =C2=A0#include <dspbridge/host_os.h>
>> > =C2=A0#include <linux/mm.h>
>> > =C2=A0#include <linux/mmzone.h>
>> > -#include <plat/control.h>
>> >
>> > =C2=A0/* =C2=A0----------------------------------- DSP/BIOS Bridge=
 */
>> > =C2=A0#include <dspbridge/dbdefs.h>
>> > @@ -74,6 +73,18 @@
>> > =C2=A0#define PAGES_II_LVL_TABLE =C2=A0 512
>> > =C2=A0#define PHYS_TO_PAGE(phys) =C2=A0 =C2=A0 =C2=A0pfn_to_page((=
phys) >> PAGE_SHIFT)
>> >
>> > +/*
>> > + * This is a totally ugly layer violation, but needed until
>> > + * omap_ctrl_set_dsp_boot*() are provided.
>> > + */
>> > +#define OMAP3_IVA2_BOOTMOD_IDLE 1
>> > +#define OMAP2_CONTROL_GENERAL 0x270
>> > +#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0=
x0190)
>> > +#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x=
0194)
>> > +
>> > +#define OMAP343X_CTRL_REGADDR(reg) \
>> > + =C2=A0 =C2=A0 =C2=A0 OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (r=
eg))
>> > +
>> > =C2=A0/* Forward Declarations: */
>> > =C2=A0static int bridge_brd_monitor(struct bridge_dev_context *dev=
_ctxt);
>> > =C2=A0static int bridge_brd_read(struct bridge_dev_context *dev_ct=
xt,
>>
>> If this makes the dspbridge usable, that sounds like the way to go
>> for the -rc cycle.
>>
>> But I don't think this the only patch needed then?
>
> I guess it would be this fix + omap: dsp: remove shm from normal memo=
ry +
> revert some drivers/staging/tidspbridge patches?
>
> It's still quite a bit of patches for the -rc cycle..

=46ine, then all you need to do is ack one patch:
http://article.gmane.org/gmane.linux.ports.arm.omap/45076

I sent this 20 days ago, it's 3 lines of diff, and it fixes a break
issue that was introduced on 2.6.37-rc1. This would not have made
sense before .37 because of the memblock changes that just got in. You
should have picked this one for the .37 merge window, there was
nothing preventing that. But it's still not too late because this is
not new code, it's a fix.

But you don't need to pick this one, all you need to do is ack it.

The rest is for Greg to decide.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
