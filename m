From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Tue, 14 Nov 2017 11:44:32 -0800
Message-ID: <20171114194432.GB28152@atomide.com>
References: <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
 <20171114173719.GA28152@atomide.com>
 <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [171114 19:34]:
> I guess you could just use rx51_secure_dispatcher and ditch the
> save_secure_ram_context call completely (and most of the other related
> code)? That one would handle the cache also in a clean manner.
> 
> Something like:
> 
> rx51_secure_dispatcher(25, 0, FLAG_START_CRITICAL, 4,
> __pa(omap3_secure_ram_storage), 0, 1, 1);

That's different, as rx51_secure_dispatcher does the following:

- Use arguments + 1 instead of 4, we currently use just 4
- Disables local_irq and fiq, we are not doing that now
- Flushes and invalidates cache range, we are not doing that
- Calls omap_smc3 that only does mov r6, #0xff, and does not
  do mov r2, #4
- Missing nops after it's done

This just based on a quick look I did earlier. So just
because of the extra work it does we don't want to do it
even if it worked :)

Regards,

Tony
