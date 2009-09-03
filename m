From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 4/4] dspbridge: Change LST_ELEM to list_head entirely
Date: Thu, 03 Sep 2009 12:17:23 +0300
Message-ID: <1251969443.5060.10.camel@localhost>
References: <1251968774-25380-1-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-2-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-3-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-4-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-5-git-send-email-andy.shevchenko@gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33209 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbZICJRe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 05:17:34 -0400
In-Reply-To: <1251968774-25380-5-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Thu, 2009-09-03 at 12:06 +0300, Andy Shevchenko wrote:
> @@ -590,7 +589,7 @@ DSP_STATUS CMM_GetInfo(struct CMM_OBJECT *hCmmMgr=
,
>  				/* next node. */
>  				pCurNode =3D (struct CMM_MNODE *)LST_Next(pAltr->
>  					pInUseListHead,
> -					(struct LST_ELEM *)pCurNode);
> +					(struct list_head *) pCurNode);

I do not completely agree with this change. Please do not put space
between the cast and the variable. The cast kind of belongs to the
variable, so it is nicer to have no space there.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
