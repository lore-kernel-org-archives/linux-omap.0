From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Fri, 3 Jan 2020 21:50:11 -0800
Message-ID: <20200104055011.GA5885@atomide.com>
References: <20191221005711.47314-1-tony@atomide.com>
 <20191221164141.GI35479@atomide.com>
 <20200104050950.GA11429@chinchilla>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200104050950.GA11429@chinchilla>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [200104 05:10]:
> On Sat, Dec 21, 2019 at 08:41:41AM -0800, Tony Lindgren wrote:
> > Also, I'm wondering if this change makes sense alone without the pinning
> > changes for a fix, or if also the pinning changes are needed.
> 
> Both pinning and page-alignment are done just to support the direct
> userspace mapping.  By themselves they mostly just waste tiler memory
> but otherwise don't really have much impact.

OK thanks, so no specific fix, that's the part I was wondering about :)

> It's not really clear to me why you have such interest in this specific
> patch.  Does my patch series fix the tearing issue you've described?  If
> so maybe without my patches tiled memory is just so slow that the frame
> is being submitted too late, which perhaps causes an async page flip
> (does it? I'm not sure) thus resulting in tearing?

Just changing the alingment fixes the issue. Looks like the minimum
alignment we currently allow is 128, I think 512 was the minimum
that worked for me, so maybe the right fix would be to just change
the minimum to 512 with no specific need to use 4096 for now.

I did not see any issue with frame updates being too slow, I just
picked that alignment change manually without trying the rest of
your series.

Regards,

Tony
