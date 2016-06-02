From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Thu, 2 Jun 2016 08:23:06 -0700
Message-ID: <20160602152305.GE5995@atomide.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
 <575025DB.9020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575025DB.9020800@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160602 05:28]:
> 
> Tony, can you have a look at the arch/arm parts here and give your ack
> if they're fine? They should be quite small and display specific, so I
> don't see much chance for conflict there.

Looks good to me, but these are going to conflict with the board-*.c
removal patches. And those we want to have easily revertable in case
of issues.

Peter, can you do an immutable minimal branch of just the pdata
changes affecting the board-*.c files? That way both Tomi and I
can merge that in.

Regards,

Tony
