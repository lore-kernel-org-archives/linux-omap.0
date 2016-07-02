From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] omapfb: omapfb-main: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 06:34:01 -0500
Message-ID: <20160702113401.GD17431@htj.duckdns.org>
References: <20160702083056.GA26936@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160702083056.GA26936@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 02, 2016 at 02:00:56PM +0530, Bhaktipriya Shridhar wrote:
> The workqueue auto_update_work is involved in auto updating mode for
> manual-update displays. omapfb driver uses a delayed work item to update
> the display at a constant rate.
> 
> Since these long-running work items aren't involved in memory reclaim in
> any way, system_long_wq has been used.

Can you please explain why this is long-running?

Thanks.

-- 
tejun
