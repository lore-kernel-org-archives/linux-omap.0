From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] OMAP SSI hardware interface definitions
Date: Fri, 3 Oct 2008 07:27:42 -0700
Message-ID: <200810030727.42701.david-b@pacbell.net>
References: <1223029515.32631.148.camel@groo.research.nokia.com> <1223029782-12009-1-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:30092 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750904AbYJCO1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:27:45 -0400
In-Reply-To: <1223029782-12009-1-git-send-email-carlos.chinea@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 03 October 2008, Carlos Chinea wrote:
>=20
> Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>

You should provide patch comments, in the form of at least
one whole sentence.  $SUBJECT is rarely felt to be enough.


> ---
> =A0arch/arm/plat-omap/include/mach/ssi/ssi_gdd_reg.h =A0| =A0145 ++++=
++++++++++++++++
> =A0.../plat-omap/include/mach/ssi/ssi_reg_common.h =A0 =A0| =A0 73 ++=
++++++++
> =A0arch/arm/plat-omap/include/mach/ssi/ssi_ssr_reg.h =A0| =A0 56 ++++=
++++
> =A0arch/arm/plat-omap/include/mach/ssi/ssi_sst_reg.h =A0| =A0 65 ++++=
+++++
> =A0arch/arm/plat-omap/include/mach/ssi/ssi_sys_reg.h =A0| =A0107 ++++=
++++++++++
> =A05 files changed, 446 insertions(+), 0 deletions(-)

Why is this five files instead of one?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
