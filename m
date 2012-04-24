From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
Date: Tue, 24 Apr 2012 10:33:01 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FAAFA@DBDE01.ent.ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <CAMQu2gzHQ-ku3akGWqUGN+EC3Jo7LtXbohqfVT=fG4Y0VFttng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34751 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab2DXKdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 06:33:09 -0400
In-Reply-To: <CAMQu2gzHQ-ku3akGWqUGN+EC3Jo7LtXbohqfVT=fG4Y0VFttng@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 24, 2012 at 15:36:43, Shilimkar, Santosh wrote:
> On Tue, Apr 24, 2012 at 3:15 PM, Vaibhav Hiremath <hvaibhav@ti.com> w=
rote:
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
> >
> > This patch series cleans up the existing 32k-sync timer implementat=
ion
> > without any major code changes, uses kernel parameter to override
> > the default clocksource of "counter_32k", also in order to support
> > some OMAP based derivative SoCs like AM33XX which doesn't have
> > 32K sync-timer hardware IP, adds hwmod lookup for omap2+
> > devices, and if lookup fails then fall back to gp-timer.
> >
> > if(use_gptimer_clksrc =3D=3D true)
> > =A0 =A0 =A0 =A0gptimer clocksource init;
> > else if (counter_32 init =3D=3D false)
> > =A0 =A0 =A0 =A0/* Fallback to gptimer */
> > =A0 =A0 =A0 =A0gptimer clocksource init(;
> >
> > With this, we should be able to support multi-omap boot
> > including devices with/without 32k-sync timer.
> >
> > This patch-series has been boot tested on AM37xEVM platform, it
> > would be helpful if somebody help me to validate it on OMAP1/2
> > platforms.
> >
> > The patches are also available at -
> > https://github.com/hvaibhav/am335x-linux =A0 32ksync-timer-cleanup
> >
> > History:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > Changes from V3:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66462.htm=
l
> > =A0 =A0 =A0 =A0- Fixed all review comments from Kevin H
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Moved counter_32k CR register offs=
et handling to
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0counter_32k.c file, so now, call=
ing funtion don't have
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to maintain or add offset to bas=
e addr.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Added comment for funtion omap_ini=
t_clocksource_32k()
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Used resource_size() for calculate=
 size
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Convert WARN_ON to pr_warn
> >
> Have given my reviewed-by on v2. Just quickly scanned the series
> based on above minor updates.
> Feel free to add,
>=20
>=20
Sorry, I missed to add your Reviewed-by here.

I believe this should be now last version, and should get merged by=20
either Tony or Paul.

Tony & Paul,
Note to add line,
"Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>"


Thanks,
Vaibhav


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
