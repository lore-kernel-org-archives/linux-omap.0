From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Fri, 05 Aug 2011 10:09:08 +0300
Message-ID: <1312528148.1907.13.camel@deskari>
References: <1309405483-6876-1-git-send-email-arve@android.com>
	 <1312459611.2143.18.camel@deskari>
	 <CAMP5XgegzAJjp8QG=Emm9TnXrn_LiVqGxTnkQ2C5_SSBbUcp7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57061 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165Ab1HEHJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 03:09:14 -0400
Received: by mail-fx0-f49.google.com with SMTP id 20so83498fxd.22
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 00:09:13 -0700 (PDT)
In-Reply-To: <CAMP5XgegzAJjp8QG=Emm9TnXrn_LiVqGxTnkQ2C5_SSBbUcp7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

On Thu, 2011-08-04 at 18:15 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> 2011/8/4 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> > Hi,
> >
> > On Wed, 2011-06-29 at 20:44 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> >> Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
> >> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> >> ---
> >>  drivers/video/omap2/dss/dsi.c |    7 ++++++-
> >>  1 files changed, 6 insertions(+), 1 deletions(-)
> >
> > This feels somehow partial... Why do you want to read generic packe=
ts if
> > there are no functions to send generic packets?
> >
>=20
> The chip responds with a generic packet when reading from some
> registers. This is a simple fix while adding support for sending
> generic packets would probably require an api change.

What command do you use to read the register? DCS? If so, sounds rather
strange HW implementation.

If you use generic commands, for which you have support in your kernel,
I think it's better to add both write and read support at the same time=
=2E
Adding just read support, without any way to actually use the read,
doesn't sound sensible.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
