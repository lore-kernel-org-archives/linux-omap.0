From: Nick Krause <xerofoify@gmail.com>
Subject: FIXME message in arch/arm/mach-omap2/gpmc-onenand.c
Date: Wed, 2 Jul 2014 22:04:32 -0400
Message-ID: <CAPDOMVh9ojHcwTkGjLtTVgKPnoYs3j54R_PFQoAF+kHAduTM2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hey Kevin,
When using csope I get a FIXME message on lines , 321 -325 in
arch/arm/mach-omap2/gpmc-onenand.c on the latest 3.16 r4 code. I was
wondering
if I can remove the legacy code or is it needed still for certain
mach-omap2 based boards.
Cheers Nick
