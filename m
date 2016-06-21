From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Date: Tue, 21 Jun 2016 22:51:41 +0100
Message-ID: <20160621215141.GC5783@n2100.arm.linux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160621165523.GY22406-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2016 at 09:55:25AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> [160621 08:46]:
> > On Tue, Jun 21, 2016 at 03:57:20AM -0700, Tony Lindgren wrote:
> > > 
> > > Maybe zImage size + MAX_RODATA_SZ + 4x zImage size?
> > > 
> > > Then the MAX_RODATA_SZ could be 2 or 4 MB or whatever we
> > > think is sufficient to kick the can until we have a better
> > > solution.
> > 
> > Maybe if you give some details about your failing case - you omitted any
> > details about the uncompressed image size...
> 
> Looks like we currently have this:
> 
> Memory: 2033088K/2095100K available (7376K kernel code, 784K rwdata,
> 2312K rodata, 1024K init, 8117K bss, 45628K reserved,
> 16384K cma-reserved, 1292284K highmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
>     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
>     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>       .text : 0xc0008000 - 0xc0a762a4   (10681 kB)
>       .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
>       .data : 0xc0c00000 - 0xc0cc411c   ( 785 kB)
>        .bss : 0xc0cc6000 - 0xc14b37f8   (8118 kB)

So that's 20.7MB, and the zImage was 3.6MB.  You're getting an
expansion ratio of 5.7x.

To fix that, we'd need to up it to 7x, but the problem with upping
it in this way is that it increases the requirements for the
crashdump region too.  We can play with this number, but there will
always be cases where it doesn't work - either because the ratio is
too big or too small.

By way of illustration, "zImage size + MAX_RODATA_SZ + 4x zImage size"
doesn't even work for this case, since you need about 25MB.  Your
calculation comes out at 22MB, which is 3MB short.  Not only that, but
it introduces (from what I can see) an irrelevant fudge factor of
"MAX_RODATA_SZ" which has no basis in what's really going on here, and
I'm left wondering what "MAX_RODATA_SZ" is actually referring to.

So... I'm of the opinion that we shouldn't play with it - but instead
try to come up with a solution which *doesn't* involve teaching kexec
a whole load of internals about how the ARM kernel booting happens.

What's more worrying to me at the moment, though, is that the kexec code
only tries to find memory for the actual "kernel" size, not the actual
space required to decompress the kernel.  It could find a chunk of
memory large enough to fit the kernel image to be loaded, but is not big
enough to allow its decompression.  kexec is really quite a mess on
ARM. :(

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
