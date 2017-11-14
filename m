From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Tue, 14 Nov 2017 12:54:06 -0800
Message-ID: <20171114205406.GC28152@atomide.com>
References: <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
 <20171114173719.GA28152@atomide.com>
 <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
 <20171114194432.GB28152@atomide.com>
 <e07fae95-2125-2d50-7295-ad58f9710801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e07fae95-2125-2d50-7295-ad58f9710801@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [171114 20:03]:
> On 14/11/17 21:44, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [171114 19:34]:
> > > I guess you could just use rx51_secure_dispatcher and ditch the
> > > save_secure_ram_context call completely (and most of the other related
> > > code)? That one would handle the cache also in a clean manner.
> > > 
> > > Something like:
> > > 
> > > rx51_secure_dispatcher(25, 0, FLAG_START_CRITICAL, 4,
> > > __pa(omap3_secure_ram_storage), 0, 1, 1);
> > 
> > That's different, as rx51_secure_dispatcher does the following:
> > 
> > - Use arguments + 1 instead of 4, we currently use just 4
> > - Disables local_irq and fiq, we are not doing that now
> > - Flushes and invalidates cache range, we are not doing that
> > - Calls omap_smc3 that only does mov r6, #0xff, and does not
> >    do mov r2, #4
> > - Missing nops after it's done
> > 
> > This just based on a quick look I did earlier. So just
> > because of the extra work it does we don't want to do it
> > even if it worked :)
> 
> Hmm ok, I was just thinking that all the extra flushes, irq disables etc.
> might be good to have in place, as a safeguard when entering secure mode.
> You might get glitches in certain conditions otherwise.

Well it's been close to 10 years already without those flushes. And
we only call this once on init.. And further changes should be a lot
easier now.

> The things it is missing might just be clutter.
> 
> Anyway, that said, the changes you did look sane, but I might have cleaned
> it up a bit further. :)

Yeah OK, let's consider that as a separate patch. This attempts
to not change the functionality, just move it out of SRAM.

Regards,

Tony
