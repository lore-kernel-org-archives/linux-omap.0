From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Thu, 06 May 2010 08:19:54 +0300 (EEST)
Message-ID: <20100506.081954.209985819.Hiroshi.DOYU@nokia.com>
References: <20100503180224.GV29604@atomide.com>
	<s2nda15981b1005040447v335b0d34k1aa812404f478cd4@mail.gmail.com>
	<20100505152135.GV29604@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37275 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab0EFFUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 01:20:04 -0400
In-Reply-To: <20100505152135.GV29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Tony,

=46rom: ext Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Wed, 5 May 2010 17:21:35 +0200

> * Ohad Ben-Cohen <ohad@wizery.com> [100504 04:42]:
>> On Mon, May 3, 2010 at 9:02 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Ohad Ben-Cohen <ohad@wizery.com> [100502 08:40]:
>> >> Fix reverse likeliness
>> >>
>> >> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> >> ---
>> >> If you want, you can also reach me at < ohadb at ti dot com >.
>> >>
>> >> =A0arch/arm/plat-omap/mailbox.c | =A0 =A04 ++--
>> >> =A01 files changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/ma=
ilbox.c
>> >> index 5140efc..5309213 100644
>> >> --- a/arch/arm/plat-omap/mailbox.c
>> >> +++ b/arch/arm/plat-omap/mailbox.c
>> >> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox=
 *mbox)
>> >> =A0 fail_alloc_txq:
>> >> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> >> =A0 fail_request_irq:
>> >> - =A0 =A0 if (unlikely(mbox->ops->shutdown))
>> >> + =A0 =A0 if (likely(mbox->ops->shutdown))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->shutdown(mbox);
>> >>
>> >> =A0 =A0 =A0 return ret;
>> >> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *=
mbox)
>> >>
>> >> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> >>
>> >> - =A0 =A0 if (unlikely(mbox->ops->shutdown)) {
>> >> + =A0 =A0 if (likely(mbox->ops->shutdown)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox_configured > 0)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_configured--;
>> >
>> > Does this code path need to be optimized? :)
>> >
>> > How about just get rid of the (un)likely here?
>>=20
>> I like this :)
>>=20
>> If we're at it, there are additional cold-path (un)likely macros I
>> want to target:
>=20
> Looks good to me.
>=20
> Hiroshi, care to ack/nak all the mailbox and iommu patches you want
> me to merge? Or if you have them in some git branch against mainline
> -rc6 that would be cool too.

=46eel free to add my ACK on them. Looks ok to me too.

If there's more patches coming, I can consider to collect patches and
to provide git branches for mailbox and iommu for next merge.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
