From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Fri, 19 Jun 2009 03:27:25 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D53F268F@zmy16exm69.ds.mot.com>
References: <13B9B4C6EF24D648824FF11BE8967162038E2ACBC9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:48074 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbZFRT14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 15:27:56 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n5IJRvOI019408
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 12:27:57 -0700 (MST)
Received: from il06vts01.mot.com (il06vts01.mot.com [129.188.137.141])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n5IJRv8K004740
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 14:27:57 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n5IJRu4Z004736
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 14:27:56 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E2ACBC9@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Mike Chan <mike@android.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of=20
> Woodruff, Richard
> Sent: 2009=C4=EA6=D4=C219=C8=D5 2:55
> To: Mike Chan; Kevin Hilman
> Cc: linux-omap@vger.kernel.org; Mike Chan
> Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state=20
> machine and kick
>=20
> Mike,
>=20
> >From: Mike Chan [mailto:mike@android.com]
> >Sent: Thursday, June 18, 2009 1:42 PM
> >
> >
> >+        /* Kick DLL state machine if lock not started */
> >+kick_dll:
> >+       ldr     r4, sdrc_dlla_ctrl      /* get dlla addr */
> >+       ldr     r5, [r4]                /* grab value */
> >+       mov     r6, r5                  /* save value */
> >
> >Richard, could this be done in one instruction, eliminating=20
> the need for the r5 >temporary register? Or was this done=20
> intentionally?
>=20
> Its on purpose I suppose, perhaps there is an optimization.
>=20
> Above I want to make sure I restore the value I came in with=20
> for dlla_ctrl.  I save off value in r5 for this.
>=20
> Below I clear and set dllidle bit.  I don't take the time to=20
> figure out if it was set or not coming into function.  I=20
> saved off value in r5 to allow for this.  It is legal for it=20
> to be set or cleared in normal operation.
>=20
> The below set/clear needs to happen as 2 writes.  The 3rd=20
> write is a restore.  You could be mindful of input value and=20
> perhaps not do a 3rd write but my guess is that will take=20
> more code then it saves.
>=20
> >+       orr     r6, r6, #0x10           /* dllidle on */
> >+       str     r6, [r4]
> >+       dsb
> >+       bic     r6, #0x10               /* dllidle off */
> >+       str     r6, [r4]
> >+       dsb
> >+       str     r6, [r4]                /* restore old value */

Richard, I think here it should be: str r5, [r4], not r6.
I modifed this when I was verifying your patch.

> >+       b wait_dll_lock_timed
> >+
>=20
> Regards,
> Richard W.
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
