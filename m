From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mtd: make onenand/generic.c more generic
Date: Fri, 7 Aug 2009 14:30:20 +0900
Message-ID: <20090807053020.GA902@linux-sh.org>
References: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se> <9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com> <aec7e5c30908042141l18b25ba4l66b3cb309f080b21@mail.gmail.com> <aec7e5c30908062228g737c1f6cr25f6c67c07d80bd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aec7e5c30908062228g737c1f6cr25f6c67c07d80bd9@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, dwmw2@infradead.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2009 at 02:28:01PM +0900, Magnus Damm wrote:
> On Wed, Aug 5, 2009 at 1:41 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
> >> On Tue, Aug 4, 2009 at 6:20 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
> >>> From: Magnus Damm <damm@igel.co.jp>
> >>>
> >>> This patch removes the ARM dependency from the generic "onenand"
> >>> platform device driver. This change makes the driver useful for
> >>> other architectures as well. Needed for the SuperH kfr2r09 board.
> >
> > On Wed, Aug 5, 2009 at 1:24 PM, Kyungmin Park<kmpark@infradead.org> wrote:
> >> Good idea add the onenand_platform_data, but dont' agree the renaming
> >> the onenand-flash.
> >> Other boards are use it even though it's not released it
> >
> > I suspected so. But this is the only reason why changed the name. =)
> >
> > If we don't change the name then the platform device will be attached
> > to the platform driver as usual, but the old platform data structure
> > will use a different binary format compated to what the driver
> > expects.
> >
> > Changing the driver name makes sure that the old device disappears and
> > that people can move over to the new name and at the same time update
> > the platform data to the new format.
> >
> >> Others are good.
> >
> > Thanks.
> >
> > I can post an updated version where I keep the driver name unchanged
> > if you prefer that. But I'm pretty sure out-of-tree drivers will break
> > with NULL pointer accesses or similar if we update the platform data
> > format without changing the name. I don't think you want that. =)
> 
> Any update on this?
> 
You have failed at reading your email:

http://lists.infradead.org/pipermail/linux-mtd/2009-August/026805.html
http://lists.infradead.org/pipermail/linux-mtd/2009-August/026809.html
