From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 19:29:06 +0000
Message-ID: <20101207192906.GA28724@n2100.arm.linux.org.uk>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 04:50:50PM +0000, Dave Martin wrote:
> I'll follow up shortly with a patch to the generic ARM Kconfig to make
> this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidentally
> be configured together.

That's a rubbish dependency.  You may have an ARCH_OMAP2 platform which
is Cortex A9, and you only have Cortex A9 support selected.  In that
case there's no reason to prevent THUMB2_KERNEL being selected.

The right thing to do is to make THUMB2_KERNEL depend on those CPUs
which are not to be selected - not by making it depend on some platform
configuration option(s) which aren't actually relevent.
