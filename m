From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF and DDR
Date: Thu, 19 Jan 2012 11:26:55 -0800
Message-ID: <CAOesGMgrfZpGhKx1yHir6WEELm5ntG5GJD3YccOvVO+HhZc6NQ@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
	<4EEFC23A.30201@gmail.com>
	<20111219233559.GW6464@atomide.com>
	<4EF0671B.7090508@ti.com>
	<4EF0824A.9060208@ti.com>
	<4EF096C9.1070808@ti.com>
	<4F09D10B.7010807@ti.com>
	<CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com>
	<4F1087C9.6030908@ti.com>
	<CAJOA=zNuVQ9zjhmA5Uc=ksOM2Q7AE4g9ddPDJ3e+QPnUfui4wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64057 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652Ab2AST04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 14:26:56 -0500
Received: by ghbg16 with SMTP id g16so208347ghb.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 11:26:56 -0800 (PST)
In-Reply-To: <CAJOA=zNuVQ9zjhmA5Uc=ksOM2Q7AE4g9ddPDJ3e+QPnUfui4wA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Aneesh V <aneesh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

Hi,

On Mon, Jan 16, 2012 at 11:15 AM, Turquette, Mike <mturquette@ti.com> w=
rote:

> And delaying DVFS (at least for the parts affecting mem) until
> userspace is loaded doesn't seem great to me either. =A0We're basical=
ly
> pushing back feature readiness (with respect to boot sequence) in the
> name of organizing data in a pretty way... but it's not a pretty
> solution since the data will have to be "split" as shown above.

Ok, so let's put the JEDEC SPD data in the device tree then. But I
fail to see how that changes the "split"? There's still two sources of
configuration, one from firmware used at boot and one from a data
structure that the kernel uses.

I do think sticking to an existing well-defined data structure such as
SPD data is to be preferred over doing an open-coded new binding. This
way, some platforms that might or might not have SPD in hardware can
use the same code paths (i.e. a board that has memory on a DIMM
instead of soldered down, or that uses soldered-down SPD).


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
