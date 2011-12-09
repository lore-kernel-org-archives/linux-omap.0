From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/7] Introducing a generic AMP framework
Date: Fri, 09 Dec 2011 16:08:02 +1030
Message-ID: <87liqmfgp1.fsf@rustcorp.com.au>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com> <874nywpfkd.fsf@rustcorp.com.au> <CAK=WgbaF=yvGXvJdENrMoi4wWxaQa3UpbtsRm3mcA3cFdDCitA@mail.gmail.com> <87obw31v31.fsf@rustcorp.com.au> <CAK=WgbYVscyeJ5Og5iPx-tjEApa2KgAR1bnZiZUUcv0HxBEtOw@mail.gmail.com> <CAK=WgbbmZR5gPqD-0Dc2jWom9J_z+iV0+nAB-BAFedbTqXk0Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbmZR5gPqD-0Dc2jWom9J_z+iV0+nAB-BAFedbTqXk0Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 8 Dec 2011 09:50:59 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Rusty,
> 
> On Wed, Nov 23, 2011 at 11:58 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > On Wed, Nov 23, 2011 at 3:33 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >> That would imply that I'd done more than glance over them, and
> >> unfortunately I haven't :(
> >
> > Np, thanks for glancing :)
> 
> I'd still like to ask for your Ack at least for the virtio_ids.h
> change (please see below, and for the full patch, see
> http://www.spinics.net/lists/linux-omap/msg59537.html):
> 
> Anyone following our threads will know you approved it, but I'm still
> technically required to have your explicit ack as long as the patch
> isn't going through your tree.
> 
> I can always add something like:
> 
> Virtio_ids.h-change-acked-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> So it doesn't imply anything else but this specific change, or I can
> just put that hunk in a separate patch, and add then add your Acked-by
> (so it doesn't imply anything on the rest of the patch set).

It's usually done:

Acked-by: Rusty Russell <rusty@rustcorp.com.au> (virtio_ids.h)

And I've added it to the next version of the virtio-spec, so noone else
grabs it.

Thanks!
Rusty.
