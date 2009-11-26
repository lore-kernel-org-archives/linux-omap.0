From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 5/9] DSPBRIDGE: trivial cleanup and indentation for
 io_sm
Date: Thu, 26 Nov 2009 07:47:12 +0200
Message-ID: <1259214432.29118.33.camel@localhost>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
	 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
	 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
	 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
	 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
	 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
	 <20091125191509.GA28486@nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29976 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZKZFrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 00:47:20 -0500
In-Reply-To: <20091125191509.GA28486@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

On Wed, 2009-11-25 at 21:15 +0200, Felipe Balbi wrote:
> On Tue, Nov 24, 2009 at 01:50:26AM +0100, ext Omar Ramirez Luna wrote=
:
> >Remove duplicate set of braces from if statement and reduce
> >indentation.
> >
> >Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> >---
> > drivers/dsp/bridge/wmd/io_sm.c |   96 +++++++++++++++++------------=
-----------
> > 1 files changed, 40 insertions(+), 56 deletions(-)
> >
> >diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd=
/io_sm.c
> >index af31831..96a5aa6 100644
> >--- a/drivers/dsp/bridge/wmd/io_sm.c
> >+++ b/drivers/dsp/bridge/wmd/io_sm.c
> >@@ -115,7 +115,7 @@ struct IO_MGR {
> > 	/* private extnd proc info; mmu setup */
> > 	struct MGR_PROCESSOREXTINFO extProcInfo;
> > 	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
> >-       struct work_struct io_workq;     /*workqueue */
> >+	struct work_struct io_workq;     /*workqueue */
>=20
> while at that: /* workqueue */
>=20
> add the missing space.
>=20
> > 	u32 dQuePowerMbxVal[MAX_PM_REQS];
> > 	u32 iQuePowerHead;
> > 	u32 iQuePowerTail;
> >@@ -185,7 +185,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phI=
OMgr,
> > 	struct CFG_HOSTRES hostRes;
> > 	struct CFG_DEVNODE *hDevNode;
> > 	struct CHNL_MGR *hChnlMgr;
> >-       static int ref_count;
> >+	static int ref_count;
> > 	u32 devType;
> > 	/* Check requirements:  */
> > 	if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize =3D=3D 0) {
> >@@ -197,9 +197,10 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **ph=
IOMgr,
> > 		status =3D DSP_EHANDLE;
> > 		goto func_end;
> > 	}
> >-	 /*  Message manager will be created when a file is loaded, since
> >+	/*  Message manager will be created when a file is loaded, since
> > 	 *  size of message buffer in shared memory is configurable in
> >-	 *  the base image.  */
> >+	 *  the base image.
> >+	 */
>=20
> same here... it should be:
>=20
> /* multi-line comment start here and has only one
>   * space after the * character.
>   * If you could remove the extra space above would
>   * be nice.
>   */

Then strictly speaking it should be

/*
 * Mulit-line comment start here.
 */

Grep for "The preferred style for long (multi-line) comments is" in
Documentation/CodingStyle.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
