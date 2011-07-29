From: mark gross <markgross@thegnar.org>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device latency
 constraints class
Date: Fri, 29 Jul 2011 07:24:59 -0700
Message-ID: <20110729142459.GA5509@gvim.org>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
 <20110728131454.GA2579@gvim.org>
 <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51754 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1G2OZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 10:25:04 -0400
Received: by gwaa12 with SMTP id a12so509485gwa.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 07:25:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 29, 2011 at 10:37:52AM +0200, Jean Pihet wrote:
> Mark,
>=20
> On Thu, Jul 28, 2011 at 3:14 PM, mark gross <markgross@thegnar.org> w=
rote:
> > On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com=
 wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> This patch set is in an RFC state, for review and comments.
> >>
> >> High level implementation:
> >>
> ...
>=20
> >> 7. Misc fixes to improve code readability:
> >> . rename of the PM QoS implementation file from pm_qos_params.[ch]=
 to pm_qos.[ch]
> > I picked the name for the file as pm_qos_params over pm_qos because=
 I
> > wanted to make it implicitly clear that this was not an full QOS
> > implementation. =A0True QOS carries expectations similar to real ti=
me and
> > as the infrastructure is closer to "good intentioned" than even "be=
st
> > effort" and offers no notification when the QOS request is not able=
 to
> > be met and really doesn't implement a true QOS at all, (it just pro=
vides
> > the parameter interface for part of one its missing the notificatio=
n
> > interface when the service level is not met and I think a few other
> > things.) So I wanted to have it named a bit different from just pm_=
qos.
> >
> > This said I'm not supper attached to the naming of the modules. =A0=
If
> > folks want to change it I wouldn't complain (too much anyway;).
> Ok got the idea. I do not know what name to chose though. As suggeste=
d
> previously the name pm_qos_params does not reflect the implementation=
,
> that is why I renamed it.

I must have missed the part where the name doesn't reflect the
implementation was talked about.  I look at the interface and I see
parameters all over the place and a small bit of notification.

--mark.

>=20
> >
> > --mark
> > PS I'll look at the rest of the patches tomorrow, this time for rea=
l as
> > I'm about to have more free time to focus on non-work stuff :)
> Thanks you for reviewing!
>=20
> > FWIW this write up sounds interesting.
> Hope it is readable ;p
>=20
> Regards,
> Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
