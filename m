From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [rtc-linux] Re: [PATCH v4 0/4] pm: Add power off control
Date: Tue, 26 Nov 2013 10:22:46 -0300
Message-ID: <20131126132245.GD2344@localhost>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
 <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
 <20131122195041.GF18968@localhost>
 <CANacCWxwr7s6ZvjWRbg_JGgc-Q1sJa-KJCLrSCK4BvSrmL5Eug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52720 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115Ab3KZNXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 08:23:24 -0500
Content-Disposition: inline
In-Reply-To: <CANacCWxwr7s6ZvjWRbg_JGgc-Q1sJa-KJCLrSCK4BvSrmL5Eug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: rtc-linux@googlegroups.com, Russ Dill <Russ.Dill@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Sat, Nov 23, 2013 at 12:23:35PM -0500, Vaibhav Bedia wrote:
> On Fri, Nov 22, 2013 at 2:50 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> [...]
> >
> > And why specifically *2* seconds, instead of *1* or *33* ?
> >
> > Sounds a bit like voodoo magic on this side :-)
>=20
> Consider the scenario where the actual time is 00:00:01.95 secs.
> Due to the 1 second resolution of the RTC, reading the registers
> would return 00:00:01. By the time we get to updating the
> RTC register for the shutdown by adding 1 sec (theoretically the
> smallest delta) we could end up programming the time that's already
> passed and in such cases the system will never shut down.
>=20
> 2 secs is the smallest delay that we can use to get the system
> to shutdown reliably.
>=20
> So it's not voodoo magic after all ;)
>=20

Right, thanks for the details.

Care to add the above explanation to a comment inside the driver?

That way, people won't ask this same question again :-)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
