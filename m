From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: Increase VMALLOC_END to allow 256MB RAM
Date: Thu, 02 Oct 2008 12:29:25 +0300
Message-ID: <87d4ijwdje.fsf@deeprootsystems.com>
References: <1222936611-19084-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:39010 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYJBJ3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 05:29:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so512814fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 02 Oct 2008 02:29:33 -0700 (PDT)
In-Reply-To: <1222936611-19084-1-git-send-email-mans@mansr.com> (Mans Rullgard's message of "Thu\,  2 Oct 2008 09\:36\:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-omap@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

> This increases VMALLOC_END to 0x18000000, making room for 256MB
> RAM with the default 128MB vmalloc region.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/plat-omap/include/mach/vmalloc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
> index d8515cb..b97dfaf 100644
> --- a/arch/arm/plat-omap/include/mach/vmalloc.h
> +++ b/arch/arm/plat-omap/include/mach/vmalloc.h
> @@ -17,5 +17,5 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> -#define VMALLOC_END	  (PAGE_OFFSET + 0x17000000)
> +#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

I have a similar patch locally, but the problem I currently have with
it is that there is no longer any hole between vmalloc space and the
beginning of IO space (the first virtual mappings start at
0xd8000000.)

It's a bit unsafe, but IMO it's is probably OK for the short term.
Longer term I think the virtual address space of the OMAP kernels
needs to be reworked.  It currenly just maps directly onto the
physical address space, which makes the IO_ADDRESS() conversion macros
simple, but leaves lots of wasted space in the virtual address space.

Kevin



