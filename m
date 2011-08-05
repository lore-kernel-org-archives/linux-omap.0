From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Fri, 05 Aug 2011 10:53:07 +0300
Message-ID: <1312530787.1907.28.camel@deskari>
References: <1309405483-6876-1-git-send-email-arve@android.com>
	 <1312459611.2143.18.camel@deskari>
	 <CAMP5XgegzAJjp8QG=Emm9TnXrn_LiVqGxTnkQ2C5_SSBbUcp7Q@mail.gmail.com>
	 <1312528148.1907.13.camel@deskari>
	 <CAMP5XgcQCL+enaiWYX4ZLkxfpQh9UhxC8_3i3h736OET4kEGhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36863 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750881Ab1HEHxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 03:53:12 -0400
Received: by mail-fx0-f54.google.com with SMTP id 4so5667444fxe.27
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 00:53:10 -0700 (PDT)
In-Reply-To: <CAMP5XgcQCL+enaiWYX4ZLkxfpQh9UhxC8_3i3h736OET4kEGhA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

Hi,

On Fri, 2011-08-05 at 00:17 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> 2011/8/5 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> > On Thu, 2011-08-04 at 18:15 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> >> 2011/8/4 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> >> > Hi,
> >> >
> >> > On Wed, 2011-06-29 at 20:44 -0700, Arve Hj=C3=B8nnev=C3=A5g wrot=
e:
> >> >> Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
> >> >> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> >> >> ---
> >> >>  drivers/video/omap2/dss/dsi.c |    7 ++++++-
> >> >>  1 files changed, 6 insertions(+), 1 deletions(-)
> >> >
> >> > This feels somehow partial... Why do you want to read generic pa=
ckets if
> >> > there are no functions to send generic packets?
> >> >
> >>
> >> The chip responds with a generic packet when reading from some
> >> registers. This is a simple fix while adding support for sending
> >> generic packets would probably require an api change.
> >
> > What command do you use to read the register? DCS? If so, sounds ra=
ther
> > strange HW implementation.
> >
>=20
> This change modifies dsi_vc_dcs_read to accept a generic response

Ok, so you do send a DCS read command, and you get a generic response.

> packet. If you want a separate generic read command that would also
> work, but the it would make it a little harder to write the driver
> since you then would need to know what type of response the chip
> sends.

Well, you do know what type of response the chip sends. According to
MIPI DSI spec, a DCS read is answered with DCS short/long response, and
a generic read is answered with generic short/long response.

If your HW doesn't work like that, it's against the spec. If a broken
chip like that was widely used, I guess we would have to add a hack for
that, but until such day I want to keep the driver working as the spec
says.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
