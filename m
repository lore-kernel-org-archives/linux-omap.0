From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Date: Wed, 22 Jun 2016 01:51:07 -0700
Message-ID: <20160622085105.GE22406@atomide.com>
References: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
 <20160622073614.GZ22406@atomide.com>
 <20160622082958.GD5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160622082958.GD5783-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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

* Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> [160622 01:32]:
> When CONFIG_DEBUG_RODATA is enabled, we align the text, read-only data,
> data, and so on to 1MB boundaries so that we can change the permissions
> of the sections to enforce the properties of the various ELF segments.
> This padding massively inflates the size of the run-time kernel image,
> and can result in megabytes of wastage (if we're as little as one byte
> into 1MB, we have to round up to the next megabyte.)

Yes understood, and looks like we cannot make any assumptions about
what the alignment might be.

> The padding, being a string of zeros, is very compressable, and this
> increases the compression ratio.
> 
> The BSS is not included in the compressed image, but needs to be taken
> account of when avoiding overwriting the DTB.
> 
> > How about we check the size of RAM available, and if there is plenty
> > of RAM we use a safe compression ratio of 8. If RAM is a problem,
> > we could make the compression ratio smaller and warn about it. And
> > we could also allow passing the compression ratio to kexec as an
> > option.
> 
> You do know that you can already pass the "size" of the kernel to be
> reserved to kexec.  --image-size.  It's not documented in --help, but
> it is there (which is another annoying thing about ARM kexec...)

Oh ok that's nice.

Regards,

Tony
