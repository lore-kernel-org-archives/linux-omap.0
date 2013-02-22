From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 08:00:44 -0800
Message-ID: <20130222160044.GA16357@quad.lixom.net>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "Fernandes, Joel A" <joelagnel@ti.com>, tony@atomide.com, "Rini, Tom" <trini@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Grant Likely <glikely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> Any comments on this approach? Is it better to merge mkfitsrc.sh with
> mkuboot.sh?

I know this was discussed quite extensively yesterday, but here is my take on
it:

Given the recent complications from multiplatform, we really saw a strong
reason to _not_ do the final boot wrapping in the kernel build system.
Produce the zImage and the DTB files, and have a surrounding script that
bundles the two in a format that your particular device needs.

Most distros have scripts to handle the "make install" step of a kernel build.
That's where this belongs, not in the actual build step.


-Olof

