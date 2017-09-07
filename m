From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Thu, 7 Sep 2017 16:30:38 +0900
Message-ID: <20170907073038.GA2111@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906133057.GH5024@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 06, 2017 at 06:30:57AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170905 16:32]:
> > I think that I made a mistake for configuration CONFIG_HIGHMEM=y and
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y. In this case, the MOVABLE_ZONE can
> > be *!highmem*. Could you check that your configuration have above
> > options?
> 
> CONFIG_HIGHMEM is set yeah.
> 
> > And, could you check that following patch works for you?
> 
> Does not seem to help, tried against next with just 9caf25f996e8
> revert and also with 9caf25f996e8.

Oops. I misunderstood your problem. Could you test with
CONFIG_DEBUG_VIRTUAL?

After commit 9caf25f996e8, user for CMA memory should use to check
PageHighmem in order to get proper virtual address of the page. If
someone doesn't use it, it is possible to use wrong virtual address
and it then causes the use of wrong physical address.
CONFIG_DEBUG_VIRTUAL would catch this case.

If it doesn't help, is there a way to test n900 configuration in QEMU?

Thanks.
