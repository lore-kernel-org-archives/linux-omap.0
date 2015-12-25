From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Fri, 25 Dec 2015 15:36:23 +0200
Message-ID: <567D4657.1070505@gmail.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

On 26.12.2013 01:12, Ivaylo Dimitrov wrote:
> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>
> On memory limited devices, CMA fails easily when asked to allocate big
> chunks of memory like framebuffer memory needed for video playback.
>
> Add boot parameter "omapfb_memsize" which allocates memory to be used
> as dma coherent memory, so dma_alloc_attrs won't hit CMA allocator when
> trying to allocate memory for the framebuffers
>
> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> ---
>   arch/arm/mach-omap2/common.c |    1 +
>   arch/arm/mach-omap2/common.h |    2 +
>   arch/arm/mach-omap2/fb.c     |   46 +++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 48 insertions(+), 1 deletions(-)
>

ping
