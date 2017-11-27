From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 22:45:08 +0100
Message-ID: <20171127214508.GA9448@lenoch>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <15209a13-c53b-068b-c0b2-f073117d39e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15209a13-c53b-068b-c0b2-f073117d39e2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Joe Perches <joe@perches.com>, SF Markus Elfring <elfring@users.sourceforge.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 27, 2017 at 03:33:13PM -0600, Andrew F. Davis wrote:
> On 11/27/2017 01:07 PM, Joe Perches wrote:
> > On Mon, 2017-11-27 at 10:43 -0600, Andrew F. Davis wrote:
> >> On 11/26/2017 12:55 PM, SF Markus Elfring wrote:
> >>> From: Markus Elfring <elfring@users.sourceforge.net>
> >>> Date: Sun, 26 Nov 2017 19:46:09 +0100
> >>>
> >>> Omit an extra message for a memory allocation failure in these functions.
> >>>
> >>> This issue was detected by using the Coccinelle software.
> >>>
> >>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >>> ---
> >>
> >> nak, unlike many others, these message give extra info on which
> >> allocation failed, that can be useful.
> > 
> > <shrug>  Not really.  There are tradeoffs.
> > 
> > There is the generic stack dump on OOM so the module/line
> > is already known.
> > 
> 
> If that is the case then I have no strong feelings either way.
> 
> > The existence of these messages increases code size which
> > also make the OOM condition slightly more likely.
> > 
> > These are generally used only at initialization and those
> > if you are OOM at initialization, bad things happen anyway
> > so where the specific OOM occurred doesn't really matter.
> > 
> 
> True, these messages will probably only ever get displayed if someone is
> messing with the allocated structs and accidentally balloons their size,
> so these are more debug statements than anything.

All those messages are result of allocation failure. The memory allocated
is later used to hold duplicate of static const data. Do we need that
copy (and thus allocation) at all?

	ladis
