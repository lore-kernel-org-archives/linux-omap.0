From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/11] Adding header file for OMAP3430
Date: Tue, 29 May 2007 09:56:17 -0700
Message-ID: <20070529165617.GD26322@atomide.com>
References: <5d5443650705290009l54024cc6k3eeaec3462512210@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF1060@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF1060@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070529 08:46]:
> Hi Trilok,
> 
> >> =======================================================================
> >> diff -purN linux-omap/include/asm-arm/arch-omap/omap34xx.h
> >val_3430_GIT/include/asm-arm/arch-omap/omap34xx.h
> >> --- linux-omap/include/asm-arm/arch-omap/omap34xx.h     2007-05-25
> >15:52:27.000000000 -0500
> >> +++ val_3430_GIT/include/asm-arm/arch-omap/omap34xx.h   2007-05-28
> >21:55:30.000000000 -0500
> >> @@ -1,3 +1,26 @@
> >> +/*
> >> + * include/asm-arm/arch-omap/omap34xx.h
> >> + *
> >> + * This file contains the processor specific definitions of the TI
> >OMAP34XX.
> >> + *
> >> + * Copyright (C) 2007 Texas Insturments.
> >> + * Copyright (C) 2007 Nokia Coporation.
> >
> >Why Copyright Nokia here?
> >
> 
> Actually this file was pushed by Paul last week, it was missing GPL header and copyrights. I added more 3430 definitions to this file and TI copyrights to header. Since it was originally written by Paul, thought of adding Nokia Copyrights too.
> 
> Tony, any suggestions? should I keep Nokia Copyrights to this header?

Well personally I don't care, but I'd assume anything that's written
by Nokia must have the Nokia copyright.

Regards,

Tony
