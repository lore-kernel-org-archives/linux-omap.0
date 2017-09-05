From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Tue, 5 Sep 2017 13:32:44 -0700
Message-ID: <20170905203240.GF5024@atomide.com>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <f62cd19e-c2e1-781e-eeb1-dce177200512@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f62cd19e-c2e1-781e-eeb1-dce177200512@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [170905 13:29]:
> On 09/05/2017 10:13 PM, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [170903 13:38]:
> >> Hi!
> >>
> >> It compiles ok, but it hangs on boot; black screen, so sometime before
> >> display is initialized.
> > 
> > Thanks for reporting it. Based on git bisect, the regression causing
> > commit is 9caf25f996e8 ("mm/cma: manage the memory of the CMA area
> > by using the ZONE_MOVABLE"). With this path applied, booting hangs
> > with an error in omap3_save_secure_ram_context() after a call to
> > _omap_save_secure_sram() that calls the related assembly code
> > save_secure_ram_context.
> > 
> > However, looks like there is also some other commit causing issue.
> > 
> > Just reverting 9caf25f996e8 on Linux next causes the oops below.
> > 
> > Anybody got ideas why this now happens?
> 
> I know that there are other two patches from the same series depending
> on the one you reverted:
> 
> mm/cma: remove ALLOC_CMA
> ARM: CMA: avoid double mapping to the CMA area if CONFIG_HIGHMEM = y
> 
> I'm guessing you need to revert all to have something consistent to test.

Thanks, yes reverting all three in next makes things boot
for me again.

Regards,

Tony
