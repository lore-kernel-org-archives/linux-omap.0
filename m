From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Tue, 13 May 2014 10:13:30 -0400
Message-ID: <5372288A.5010403@ti.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>	<20140512195050.GB5668@atomide.com>	<CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>	<20140512201517.GC5668@atomide.com>	<CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com>	<20140512204213.GD5668@atomide.com>	<CAOCHtYgg7jwxswH+mqF3RA7-0RP-nGuft+Ze-GRwu1fbA6+0Bw@mail.gmail.com>	<537215D3.70306@ti.com> <CABxcv=nq9XvyN0aPOBFDm0UyoaW-Htyy0tyP3YhYaDnDUo3a5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=nq9XvyN0aPOBFDm0UyoaW-Htyy0tyP3YhYaDnDUo3a5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, Matt Ranostay <mranostay@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Matt Porter <matt.porter@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 05/13/2014 10:06 AM, Javier Martinez Canillas wrote:

> Agreed. I think that until the device tree overlay and the cape
> manager find their way into mainline we should treat capes as if they
> were expansion boards attached to a Computer-on-Module. That is, a
> static based board which its own DTS including the BB{B,W} as an dtsi
> and not something that can be added on runtime.

Sometimes nothing exposes just how big a problem something is (and how
much we need the solution to it) like actually showing the output.
Someone could also start posting the profileN device trees for the
am335x GP EVMs too.

-- 
Tom
