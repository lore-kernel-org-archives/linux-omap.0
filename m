From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] fbdev: Remove deprecated create_singlethread_workqueue
Date: Sat, 2 Jul 2016 06:36:35 -0500
Message-ID: <20160702113635.GF17431@htj.duckdns.org>
References: <20160702083923.GA27352@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160702083923.GA27352@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 02, 2016 at 02:09:23PM +0530, Bhaktipriya Shridhar wrote:
> The workqueue "esd_wq" has only a single workitem(&md->esd_work)
> and hence doesn't require ordering. Also, it is not being used on a
> memory reclaim path. Hence, the singlethreaded workqueue has been
> replaced with the use of system_wq.
> 
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
> 
> mipid_esd_stop_check () calls cancel_delayed_work() in mipid_cleanup()
> to ensure that there are no pending tasks while disconnecting the driver.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
