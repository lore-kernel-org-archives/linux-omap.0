From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Fri, 14 Jan 2011 12:47:10 +0530
Message-ID: <c77cce3143f47a793057b2a9a90a277b@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
 <AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
 <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
 <aed955b665a0511402480c258615c2d8@mail.gmail.com> <AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com>
 <e56efff1efde6669f06463a9af017967@mail.gmail.com> <AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:36904 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980Ab1ANHRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 02:17:13 -0500
Received: by mail-fx0-f41.google.com with SMTP id 12so2466218fxm.28
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 23:17:12 -0800 (PST)
In-Reply-To: <AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: TAO HU <tghk48@motorola.com>, TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: cooloney@gmail.com [mailto:cooloney@gmail.com] On Behalf Of
> Bryan Wu
> Sent: Friday, January 14, 2011 3:08 AM
> To: Santosh Shilimkar
> Cc: TAO HU; TAO HU; linux-omap
> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>
> On Wed, Nov 24, 2010 at 2:23 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: TAO HU [mailto:tghk48@motorola.com]
> >> Sent: Wednesday, November 24, 2010 11:40 AM
> >> To: Santosh Shilimkar
> >> Cc: TAO HU; Bryan Wu; linux-omap
> >> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external
> abort
> >>
> >> Hi, Santosh
> >>
> >> Could you point out the specific kernel option for "L3 error
> debugging"?
> >>
> > System Type =A0--->
> > =A0 =A0 =A0 =A0[*] Enable L3 error logging
> >
>
> I've enabled that for my Panda kernel. How to get the error log? I
> still got the same "Unhandled fault: imprecise external abort"
> message. Maybe L3 does not have any error at all.
>
Strange. It should have  triggered an L3 eror interrupt.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
