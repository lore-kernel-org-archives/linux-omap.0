From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global data
Date: Wed, 8 May 2013 16:07:54 +0200
Message-ID: <201305081607.54839.arnd@arndb.de>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org> <20130508071137.GM25742@login.drsnuggles.stderr.nl> <518A582C.8070600@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <518A582C.8070600-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 May 2013, Rob Herring wrote:
> On 05/08/2013 02:11 AM, Matthijs Kooijman wrote:

> > https://lkml.org/lkml/2012/12/4/54
> > 
> > And here's the previous attempt, to which Rob Herring refers in a reply.
> > 
> > https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-March/013180.html
> 
> I believe most of the issues have been around supporting ARM LPAE
> systems. There is a much more simple approach to address this by using
> the dma_addr_t size to set the coherent_dma_mask which I have queued for
> 3.11:
> 
> https://patchwork-mail1.kernel.org/patch/2495861/

Hmm, this approach seems wrong -- a lot of devices I expect cannot
actually do DMA to addresses beyond 4GB. A better default would
be to use a 32 bit mask for all devices and override the ones that
actually matter for performance and are known to be 64-bit DMA
capable.

Laura, you obviously tried this code on an LPAE-enabled system. Have
you had a look in the hardware manual which DMA masters in the
system are actually 64-bit capable?

	Arnd
