From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: Fixes warning on suspend errors
Date: Wed, 28 Oct 2009 23:06:34 +0100
Message-ID: <200910282306.34431.rjw@sisk.pl>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DC96A@dbde02.ent.ti.com> <Pine.LNX.4.44L0.0910270936450.2882-100000@iolanthe.rowland.org> <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCA79@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752873AbZJ1WE7@vger.kernel.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCA79@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Hilman, Kevin" <khilman@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 October 2009, Dasgupta, Romit wrote:
> Ok. Then the following is the refined and probably more appropriate one.
> 
> 
> 
> This fixes the point where we need to complete the power transition when 
> device suspend fails.
> 
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e0dc407..3d0b26a 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -444,6 +444,7 @@ static void dpm_resume(pm_message_t state)
>  
>  	INIT_LIST_HEAD(&list);
>  	mutex_lock(&dpm_list_mtx);
> +	transition_started = false;
>  	while (!list_empty(&dpm_list)) {
>  		struct device *dev = to_device(dpm_list.next);
> 

Applied to suspend-2.6/linux-next.

Thanks,
Rafael
