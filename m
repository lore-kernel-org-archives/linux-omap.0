From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 11:15:10 -0500
Message-ID: <A24693684029E5489D1D202277BE89447260B287@dlee02.ent.ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<1284686973-13993-1-git-send-email-nm@ti.com>
	<A24693684029E5489D1D202277BE89447260B073@dlee02.ent.ti.com>
	<4C93898B.2070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andi Kleen <ak@linux.intel.com>, "Sripathy,
	Vishwanath" <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "romit@ti.com" <romit@ti.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pws>
List-Id: linux-omap@vger.kernel.org

Nishanth,

<snip>

> > >> diff --git a/include/linux/opp.h b/include/linux/opp.h
> > >> new file mode 100644
> > >> index 0000000..94a552b
> > >> --- /dev/null
> > >> +++ b/include/linux/opp.h
> > >> @@ -0,0 +1,136 @@
> > >> +/*
> > >> + * Generic OPP Interface
> > >> + *
> > >> + * Copyright (C) 2009-2010 Texas Instruments Incorporated.
> > >> + *   Nishanth Menon
> > >> + *   Romit Dasgupta <romit@ti.com>
> > >> + * Copyright (C) 2009 Deep Root Systems, LLC.
> > >> + *   Kevin Hilman
> > >
> > > Just curious why only Romit's e-mail address is there, and not Kevin's
> > or
> > > yours...
> >
> > personal choice I guess, Romit prefered his email id added Kevin and I
> > did not.
> 
> OK. No problem then :)

Actually, Romit's e-mail address seems to be invalid... Is he still having that address? (OR is he still working in TI? 8-| )

Regards,
Sergio

<snip>
