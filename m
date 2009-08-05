From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
Date: Wed, 5 Aug 2009 14:40:06 +0530 (IST)
Message-ID: <54857.192.168.10.89.1249463406.squirrel@dbdmail.itg.ti.com>
References: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
    <200907021727.12048.david-b@pacbell.net>
    <EAF47CD23C76F840A9E7FCE10091EFAB02B55019A3@dbde02.ent.ti.com>
    <20090805085815.GC7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933639AbZHEJK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Aug 2009 05:10:26 -0400
In-Reply-To: <20090805085815.GC7374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, David Brownell <david-b@pacbell.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090703 07:52]:
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org
>> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David Brown=
ell
>> > Sent: Friday, July 03, 2009 5:57 AM
>> > To: Syed, Rafiuddin
>> > Cc: spi-devel-general@lists.sourceforge.net;
>> > linux-omap@vger.kernel.org
>> > Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
>> >
>> > On Monday 29 June 2009, Syed Rafiuddin wrote:
>> > > This patch adds McSPI support for OMAP4430 SDP platform.
>> > All the base addresses
>> > > are changed between OMAP1/2/3 and OMAP4.The fields of the
>> > resource structures
>> > > are filled at runtime to have McSPI support on OMAP4.
>> > >
>> > > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
>> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>> > > Acked-by: Tony Lindgren <tony@atomide.com>
>> > > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >
>> > I'd add my ack if this patch weren't mangled.  :)
>> >
>> > > ---
>> > > =A0arch/arm/mach-omap2/devices.c | =A0 25 +++++++++++++++++++++-=
---
>> >
>> > Since *most* of this is arch/arm stuff, I think this patch
>> > should go to mainine through Tony.  That's the best way to
>> > make sure it doesn't cause conflicts with other patches he
>> > sends.
>>
>> Tony suggested that this patch can be sent through SPI mailing list.
>> Refer this thread.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14011.html
>
> Just to confirm, this is OK for me to merge via the SPI once the
> mangling is removed.
>
> Tony

I have resubmitted the patch by removing the mangling, It can be found
at this link location
http://marc.info/?l=3Dlinux-omap&m=3D124827089126638&w=3D2

>
>
>
>> >
>> > > =A0drivers/spi/omap2_mcspi.c =A0 =A0 | =A0 10 ++++++----
>> > > =A02 files changed, 27 insertions(+), 8 deletions(-)
>> >
>> > None of this seemed particularly controversial.
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
