From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 16:44:26 +0000
Message-ID: <20130318164426.GI30923@n2100.arm.linux.org.uk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130222160044.GA16357@quad.lixom.net> <20130318163648.GA3722@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130318163648.GA3722@amd.pavel.ucw.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Olof Johansson <olof@lixom.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Joel A Fernandes <agnel.joel@gmail.com>, "Rini, Tom" <trini@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 18, 2013 at 05:36:53PM +0100, Pavel Machek wrote:
> On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> > On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > > mkuboot.sh?
> > 
> > I know this was discussed quite extensively yesterday, but here is my take on
> > it:
> > 
> > Given the recent complications from multiplatform, we really saw a strong
> > reason to _not_ do the final boot wrapping in the kernel build system.
> > Produce the zImage and the DTB files, and have a surrounding script that
> > bundles the two in a format that your particular device needs.
> > 
> > Most distros have scripts to handle the "make install" step of a kernel build.
> > That's where this belongs, not in the actual build step.
> 
> Not sure I agree here:
> 
> 1) zImage was designed to boot from floppy, without any kind of
> bootloader on i386

zImage on x86 != zImage on ARM.

They only share the fact that they're both compressed and self-extracting.

ARM has never supported any kind of floppy based boot - mainly because
floppies have never been "executable" like they are on x86; all that
previous boot loaders ever did was load the kernel into RAM using some
method and call address 0, with a data structure (formerly struct
params, later atags) at a fixed address, later passing that address to
the kernel.

The best floppies got was being able to run a script or load an executable
off the floppy under the ROM'd OS, and our zImage itself doesn't fit the
format required for that.

Our zImage has always been just a pure straight binary compressed kernel
format.  Nothing more.
