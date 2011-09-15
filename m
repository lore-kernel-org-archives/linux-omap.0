From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Kernel Halt with framebuffer enabled: omap_mbox_get()
Date: Thu, 15 Sep 2011 16:11:49 +0300
Message-ID: <CAK=WgbZW4fU7Bh-_GidV+K2sQXuNqgTR4EUv-UV6hVp2D9awSA@mail.gmail.com>
References: <E7A479031C7DF74280EF342B1F6615F50A448AB8@KELS-MAIL-001.eu.plexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60914 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933677Ab1IONMK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 09:12:10 -0400
Received: by wwf22 with SMTP id 22so3667549wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 06:12:09 -0700 (PDT)
In-Reply-To: <E7A479031C7DF74280EF342B1F6615F50A448AB8@KELS-MAIL-001.eu.plexus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stuart Brown <Stuart.Brown@plexus.com>
Cc: linux-omap@vger.kernel.org, Brian Murray <Brian.Murray@plexus.com>

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
