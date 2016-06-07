From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Mon, 6 Jun 2016 22:51:16 -0700
Message-ID: <20160607055116.GB22406@atomide.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
 <575025DB.9020800@ti.com>
 <20160602152305.GE5995@atomide.com>
 <57516121.1010201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57516121.1010201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160603 03:53]:
> 
> 
> On 02/06/16 18:23, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [160602 05:28]:
> >>
> >> Tony, can you have a look at the arch/arm parts here and give your ack
> >> if they're fine? They should be quite small and display specific, so I
> >> don't see much chance for conflict there.
> > 
> > Looks good to me, but these are going to conflict with the board-*.c
> > removal patches. And those we want to have easily revertable in case
> > of issues.
> > 
> > Peter, can you do an immutable minimal branch of just the pdata
> > changes affecting the board-*.c files? That way both Tomi and I
> > can merge that in.
> 
> I wonder how minimal it can be, as I think most of the patches are
> needed for pdata changes. Well, Peter can tell better.

Looks like Peter's new series deals with it just fine.

> What board changes do you expect for the next merge window? If it's just
> "git rm boardfile.c", that should be an easy conflict to resolve, right?

Trivial but no need to create these merge conflicts here.

Regards,

Tony
