From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Sun, 5 Jan 2020 12:37:04 -0800
Message-ID: <20200105203704.GD5885@atomide.com>
References: <20191221005711.47314-1-tony@atomide.com>
 <20191221164141.GI35479@atomide.com>
 <20200104050950.GA11429@chinchilla>
 <20200104055011.GA5885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200104055011.GA5885@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Matthijs van Duin <matthijsvanduin@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [200104 05:51]:
> 
> Just changing the alingment fixes the issue. Looks like the minimum
> alignment we currently allow is 128, I think 512 was the minimum
> that worked for me, so maybe the right fix would be to just change
> the minimum to 512 with no specific need to use 4096 for now.

So Matthijs and I chatted about this a bit on irc, and here's what
we concluded so far:

1. We have at least three different alignment needs for tiler

- Linux use of tiler aligned to 128 bytes

- SGX use of tiler aligned to 4096 bytes (or 512 bytes?)

- Fast userspace mapping aligned to 4096 bytes

2. The alignment need may need to be configured by the tiler consumer
   in #1 above

3. The alignment need for SGX seems to be based on SGX MMU page size

4. The issue I'm seeing with stellarium on droid4 may be a stride
   issue as about one out of 3 or 4 frames is OK and aligning to
   512 also fixes the issue maybe because it happens to make
   multiple frames align to 4096

So let's wait on this patch until we have more info and know how
the different alignments should be handled.

Regards,

Tony
