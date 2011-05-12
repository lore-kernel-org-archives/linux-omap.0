From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Fri, 13 May 2011 00:46:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53784 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab1ELTQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 15:16:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CJGNL4023947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 14:16:25 -0500
In-Reply-To: <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=20

> -----Original Message-----
> From: Menon, Nishanth=20
> Sent: Thursday, May 12, 2011 11:32 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with=20
> debugfs disabled
>=20
> On Thu, May 12, 2011 at 12:36, Sanjeev Premi <premi@ti.com> wrote:
> > There is an implicit assumption in current implementation that
> > debugfs is always enabled.
> thanks for doing this.
> >
> > When debugfs is disabled, these errors are noticed during boot:
> > =A0omap_voltage_late_init: Unable to create voltage debugfs main di=
r
> > =A0vdd_debugfs_init: Unable to create debugfs directory for vdd_mpu
> > =A0vdd_debugfs_init: Unable to create debugfs directory for vdd_cor=
e
> >
> > This patch fixes these errors by enclosing code related to debugfs
> > in #ifdef CONFIG_DEBUG_FS..#endif.
>=20
> generic - couple of comments - I think the #defs should be isolated
> off to headers - maybe the right approach may be to move the debugfs

[sp] None of the code encapsulated here is "header" material.
     I guess you have seen the patch below.

> entries off to a separate file? or pm-debug.c??

[sp] I wish it was all debug code. It is "operational" code.
     Check the Kconfig in plat-omap. Smartreflex is not even expected
     to work without debugfs. Though I believe much of the data put in
     debugfs can be in local lists/structures.

     That was supposed to be my next set of patches - as I understand=20
     the implementation better.
>=20
> >
> > Boot tested on OMAP3EVM.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> > =A0Patch was created and tested on the pm branch at commit:
> > =A0 d695569 : rebuild PM from branches
>=20
> Could I suggest Kevin's volt cleanup series - based off _c branch if
> there are cleanups to be done?

[sp] I didn't see it updated for 5 weeks. hence used this.
     but patch should apply cleanly...

>=20
> >
> > =A0I am still finding my way around new code sructure. Haven't
> > =A0been able to verify if smartreflex and voltage layer are
> > =A0properly initialized. Though I do understand that smartreflex
> > =A0won't work without debugfs.
> >
>=20
> Last I tried, with Vishwa's dvfs branch on panda without voltage
> registrations, things could crash :( if I get some time I will try to
> port Vishwa's series onto kevin's branch as well and test and provide
> any patches necessary.

[sp] I can try this on Panda. Will be able to get one tomorrow.

~sanjeev

[snip]...[snip]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
