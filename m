From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 01/11] OMAP: DMA: Introduce DMA device attributes
Date: Wed, 4 Aug 2010 23:43:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032162396E@dbde02.ent.ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
 <1280397545-27323-2-git-send-email-manjugk@ti.com> <4C5175A6.5020101@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402707515AE@dbde02.ent.ti.com>
 <4C593D50.4010908@ti.com>,<E0D41E29EB0DAC4E9F3FF173962E9E9402708B4F1A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32823 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756983Ab0HDSQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 14:16:03 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402708B4F1A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

G, Manjunath Kondaiah [manjugk@ti.com] wrote:
> > From: Cousson, Benoit
> > On 7/30/2010 5:57 AM, G, Manjunath Kondaiah wrote:
> >
> > <snip>
> >
> > >>> +/* Attributes for OMAP DMA Contrllers */
> > >>> +#define ENABLE_1510_MODE         (1<<   0)
> > >>> +#define DMA_LINKED_LCH                   (1<<   1)
> > >>> +#define GLOBAL_PRIORITY                  (1<<   2)
> > >>> +#define RESERVE_CHANNEL                  (1<<   3)
> > >>> +#define SRC_PORT                 (2<<   3)
> > >>> +#define DST_PORT                 (2<<   4)
> > >>> +#define IS_CSSA_32                       (2<<   5)
> > >>> +#define IS_CDSA_32                       (2<<   6)
> > >>> +#define SRC_INDEX                        (4<<   6)
> > >>> +#define DST_INDEX                        (4<<   7)
> > >>> +#define IS_BURST_ONLY4                   (4<<   8)
> > >>> +#define CLEAR_CSR_ON_READ                (4<<   9)
> > >>> +#define IS_WORD_16                       (8<<   9)
> > >>> +#define IS_RW_PRIORIY                    (8<<   0xA)
> > >>
> > >> It is a minor detail, but why are you shifting both side of the
> > >> operator? It is really confusing, cannot you just do 1<<  X?
> > >> With 0<  X<  13.
> > > I can change this if it is confusing to others.
> >
> > So you are still convince that this is a good way to do it???
> > What is the rational behind that?
> > Why adding potential source of confusion when you can avoid
> > that easily?
> 
> There is no specific reason/rationale. Left side bit keeps incrementing
> for every four bits and right side bit keeps incrementing every time except
> during left bit increment.
> As I mentioned earlier, I can change this to your logic or we can have something like:
> 0x0001, 0x0002, 0x0004, 0x0008, 0x0010 ...
> 
> -Manjunath

Please, just use BIT(i) for things like these.

It's much more clear, when you look up some bitfield in the TRM.

The TRM doesn't group the bits within a register in groups of 4,
and you'll need to do more mental math to figure out what you're
looking at.

- Anand
