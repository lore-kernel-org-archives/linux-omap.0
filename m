From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 4/4] mtd: OneNAND: OMAP2: increase multiblock erase
 verify timeout
Date: Fri, 18 Feb 2011 06:31:38 +0200
Message-ID: <1298003498.2735.4.camel@localhost>
References: <1297068421-14430-1-git-send-email-adrian.hunter@nokia.com>
	 <1297068421-14430-5-git-send-email-adrian.hunter@nokia.com>
	 <20110217234603.GI20795@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62790 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BREcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 23:32:54 -0500
Received: by ewy5 with SMTP id 5so1411829ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 20:32:53 -0800 (PST)
In-Reply-To: <20110217234603.GI20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi,

On Thu, 2011-02-17 at 15:46 -0800, Tony Lindgren wrote:
> * Adrian Hunter <adrian.hunter@nokia.com> [110207 00:45]:
> > From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> >=20
> > The current multiblock erase verify read timeout 100us is the maxim=
um
> > for none-error case. If errors happen during multibock erase then
> > the specification recommends to run multiblock erase verify command
> > with maximum timeout 10ms (see specs. for KFM4G16Q2A and KFN8G16Q2A=
).
> >=20
> > For the most common non-error case we wait 100us in udelay polling
> > loop. In case of timeout the interrupt mode is used to wait for the
> > command end.
> >=20
> > Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
>=20
> I'll queue this series. Anybody from MTD list care to ack this patch?

Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
