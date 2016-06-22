From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Date: Wed, 22 Jun 2016 09:29:59 +0100
Message-ID: <20160622082958.GD5783@n2100.arm.linux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
 <20160622073614.GZ22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160622073614.GZ22406-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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

On Wed, Jun 22, 2016 at 12:36:16AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> [160621 14:54]:
> > So that's 20.7MB, and the zImage was 3.6MB.  You're getting an
> > expansion ratio of 5.7x.
> > 
> > To fix that, we'd need to up it to 7x, but the problem with upping
> > it in this way is that it increases the requirements for the
> > crashdump region too.  We can play with this number, but there will
> > always be cases where it doesn't work - either because the ratio is
> > too big or too small.
> 
> OK
> 
> > By way of illustration, "zImage size + MAX_RODATA_SZ + 4x zImage size"
> > doesn't even work for this case, since you need about 25MB.  Your
> > calculation comes out at 22MB, which is 3MB short.  Not only that, but
> > it introduces (from what I can see) an irrelevant fudge factor of
> > "MAX_RODATA_SZ" which has no basis in what's really going on here, and
> > I'm left wondering what "MAX_RODATA_SZ" is actually referring to.
> 
> Well I thinking the section alignment split might give us some
> known size for rodata, but looking at it more it's only with
> DEBUG_ALIGN_RODATA. If we can't make any assumptions about the
> size of the rodata, then no point adding it.

I think you're just getting completely confused about what the problem
is, due to the naming of the config option.

It's got nothing to do with the size of the read-only data.  Really.

When CONFIG_DEBUG_RODATA is enabled, we align the text, read-only data,
data, and so on to 1MB boundaries so that we can change the permissions
of the sections to enforce the properties of the various ELF segments.
This padding massively inflates the size of the run-time kernel image,
and can result in megabytes of wastage (if we're as little as one byte
into 1MB, we have to round up to the next megabyte.)

The padding, being a string of zeros, is very compressable, and this
increases the compression ratio.

The BSS is not included in the compressed image, but needs to be taken
account of when avoiding overwriting the DTB.

> How about we check the size of RAM available, and if there is plenty
> of RAM we use a safe compression ratio of 8. If RAM is a problem,
> we could make the compression ratio smaller and warn about it. And
> we could also allow passing the compression ratio to kexec as an
> option.

You do know that you can already pass the "size" of the kernel to be
reserved to kexec.  --image-size.  It's not documented in --help, but
it is there (which is another annoying thing about ARM kexec...)

> I forgot if we still have some 128MB limits too..

We do.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
