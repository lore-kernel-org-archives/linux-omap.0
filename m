From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Mon, 18 Sep 2017 11:01:26 +0900
Message-ID: <20170918020126.GA19200@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170915131817.GA19486@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915131817.GA19486@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 15, 2017 at 03:18:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > After commit 9caf25f996e8, user for CMA memory should use to check
> > > PageHighmem in order to get proper virtual address of the page. If
> > > someone doesn't use it, it is possible to use wrong virtual address
> > > and it then causes the use of wrong physical address.
> > > CONFIG_DEBUG_VIRTUAL would catch this case.
> > 
> > OK, no extra output of current next with CONFIG_DEBUG_VIRTUAL=y.
> > Booting of n900 hangs with just the same error:
> > 
> > save_secure_sram() returns 0000ff02
> > 
> > > If it doesn't help, is there a way to test n900 configuration in QEMU?
> > 
> > I doubt that QEMU n900 boots in secure mode but instead shows
> > the SoC as general purpose SoC. If so, you'd have to patch the
> > omap3_save_secure_ram_context() to attempt to save secure RAM
> > context in all cases. If that works then debugging with any
> > omap3 board like beagleboard in QEMU should work.
> 
> Okay, linux-next from today still does not boot on n900. Is it
> something new, or was this still not fixed in -next?

Hello,

Still not fixed in -next since I cannot regenerate the error.

Thanks.
