From: "Stuart Brown" <Stuart.Brown@plexus.com>
Subject: RE: Kernel Halt with framebuffer enabled: omap_mbox_get()
Date: Thu, 15 Sep 2011 14:40:59 +0100
Message-ID: <E7A479031C7DF74280EF342B1F6615F50A496148@KELS-MAIL-001.eu.plexus.com>
References: <E7A479031C7DF74280EF342B1F6615F50A448AB8@KELS-MAIL-001.eu.plexus.com>
    <CAK=WgbZW4fU7Bh-_GidV+K2sQXuNqgTR4EUv-UV6hVp2D9awSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-outbound-4.plexus.com ([64.215.193.238]:26685 "EHLO
	mail-outbound-4.plexus.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933125Ab1IONlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:41:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <CAK=WgbZW4fU7Bh-_GidV+K2sQXuNqgTR4EUv-UV6hVp2D9awSA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Brian Murray <Brian.Murray@plexus.com>

Thanks Ohad,

It looks like this patch is missing from the arago-project linux-omap3 =
code base.

We've been using the most recent release - T1816XPSP_04.00.00.12.

What would the procedure be to get this patch applied to the arago-proj=
ect?=20

Stuart

-----Original Message-----
=46rom: Ohad Ben-Cohen [mailto:ohad@wizery.com]=20
Sent: 15 September 2011 14:12
To: Stuart Brown
Cc: linux-omap@vger.kernel.org; Brian Murray
Subject: Re: Kernel Halt with framebuffer enabled: omap_mbox_get()

Hi Stuart,

On Thu, Sep 15, 2011 at 3:22 PM, Stuart Brown <Stuart.Brown@plexus.com>=
 wrote:
> Doing some investigation it looks like the for loop in mach-omap2/mai=
lbox.c: omap_mbox_get() might be wrong:
>
> =A0 =A0 =A0for(mbox =3D *mboxes; mbox; mbox++)
=2E..
> I'm hesitant to query this as it looks like this change has been in t=
he kernel for about a year, so perhaps I'm missing something?

You're probably missing the following patch from Kevin:

commit c03773206bf2249a890c4d420ed32ef500630095
Author: Kevin Hilman <khilman@ti.com>
Date:   Fri Feb 11 19:56:43 2011 +0000

    OMAP2+: mailbox: fix lookups for multiple mailboxes

    The pointer math in omap_mbox_get() is not quite right, and leads t=
o
    passing NULL to strcmp() when searching for an mbox that is not fir=
st
    in the list.

    Convert to using array indexing as is done in all the other functio=
ns
    which walk the mbox list.

    Tested on OMAP2420/n810, OMAP3630/zoom3, OMAP4430/Blaze

    Signed-off-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.=
c
index 459b319..49d3208 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -322,15 +322,18 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)

 struct omap_mbox *omap_mbox_get(const char *name, struct notifier_bloc=
k *nb)
 {
-	struct omap_mbox *mbox;
-	int ret;
+	struct omap_mbox *_mbox, *mbox =3D NULL;
+	int i, ret;

 	if (!mboxes)
 		return ERR_PTR(-EINVAL);

-	for (mbox =3D *mboxes; mbox; mbox++)
-		if (!strcmp(mbox->name, name))
+	for (i =3D 0; (_mbox =3D mboxes[i]); i++) {
+		if (!strcmp(_mbox->name, name)) {
+			mbox =3D _mbox;
 			break;
+		}
+	}

 	if (!mbox)
 		return ERR_PTR(-ENOENT);


Plexus Corp.=20
Registered address: Pinnacle Hill, Kelso, Roxburghshire, TD5 8XX.=20
Registered in Scotland: number SC146948.

This email transmission is confidential and intended solely for the per=
son or organisation to whom it is addressed. If you are not the intende=
d recipient, you must not copy, distribute or disseminate the informati=
on, or take any action in reliance of it. Any views expressed in this m=
essage are those of the individual sender, except where the sender spec=
ifically states them to be the views of Plexus Corp. If you have receiv=
ed this message in error, do not open any attachment but please notify =
the sender (above) deleting this message from your system. Please rely =
on your own virus check no responsibility is taken by the sender for an=
y damage rising out of any bug or virus infection.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
