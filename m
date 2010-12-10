From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire
 during suspend
Date: Thu, 9 Dec 2010 16:57:17 -0800
Message-ID: <20101210005717.GP3054@atomide.com>
References: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
 <AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
 <87zksfc53b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26525 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab0LJA5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 19:57:24 -0500
Content-Disposition: inline
In-Reply-To: <87zksfc53b.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101209 07:40]:
> Vitaly Wool <vitalywool@gmail.com> writes:
> >>
> >> +static void omap2_pm_end(void)
> >> +{
> >> + =C2=A0 =C2=A0 =C2=A0 suspend_state =3D PM_SUSPEND_ON;
> >> + =C2=A0 =C2=A0 =C2=A0 return;
> >> +}
> >
> > Redundant return.
>=20
> but harmless

I'll queue this fix, will leave out the harmless return.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
