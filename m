From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Date: Wed, 22 Jun 2016 00:36:16 -0700
Message-ID: <20160622073614.GZ22406@atomide.com>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160621215141.GC5783-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> [160621 14:54]:
> So that's 20.7MB, and the zImage was 3.6MB.  You're getting an
> expansion ratio of 5.7x.
> 
> To fix that, we'd need to up it to 7x, but the problem with upping
> it in this way is that it increases the requirements for the
> crashdump region too.  We can play with this number, but there will
> always be cases where it doesn't work - either because the ratio is
> too big or too small.

OK

> By way of illustration, "zImage size + MAX_RODATA_SZ + 4x zImage size"
> doesn't even work for this case, since you need about 25MB.  Your
> calculation comes out at 22MB, which is 3MB short.  Not only that, but
> it introduces (from what I can see) an irrelevant fudge factor of
> "MAX_RODATA_SZ" which has no basis in what's really going on here, and
> I'm left wondering what "MAX_RODATA_SZ" is actually referring to.

Well I thinking the section alignment split might give us some
known size for rodata, but looking at it more it's only with
DEBUG_ALIGN_RODATA. If we can't make any assumptions about the
size of the rodata, then no point adding it.

> So... I'm of the opinion that we shouldn't play with it - but instead
> try to come up with a solution which *doesn't* involve teaching kexec
> a whole load of internals about how the ARM kernel booting happens.
> 
> What's more worrying to me at the moment, though, is that the kexec code
> only tries to find memory for the actual "kernel" size, not the actual
> space required to decompress the kernel.  It could find a chunk of
> memory large enough to fit the kernel image to be loaded, but is not big
> enough to allow its decompression.  kexec is really quite a mess on
> ARM. :(

How about we check the size of RAM available, and if there is plenty
of RAM we use a safe compression ratio of 8. If RAM is a problem,
we could make the compression ratio smaller and warn about it. And
we could also allow passing the compression ratio to kexec as an
option.

I forgot if we still have some 128MB limits too..

Regards,

Tony
