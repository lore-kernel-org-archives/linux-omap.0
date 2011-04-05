From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 08:56:22 +0100
Message-ID: <20110405075622.GB4699@n2100.arm.linux.org.uk>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1301989401-11984-1-git-send-email-j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> parameter "u32 mask" type cast befor inversion

Nak.  I want a 32-bit all ones quantity.

unsigned long long vali = (unsigned short)~0;
unsigned long long vall = ~(unsigned short)0;

compiles to:

vali:
        .word   65535
        .word   0

vall:
        .word   -1
        .word   -1

So moving the ~ to be evaluated after the cast has the effect of making
the cast pointless, and produces wrong values.  (u32)~0 does the 32-bit
cast _after_ the inversion which ensures that its always truncated to
a 32-bit value.

As the function is declared as taking a u32, the cast isn't needed.  If
the function gets changed to take a u64, the casts will need to be
re-added.  So, (u32)~0 makes the fact that we want a 32-bit all-ones
mask explicit.
