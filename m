From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem
Date: Sat, 28 May 2011 11:01:13 +0200
Message-ID: <201105281101.13691.rjw@sisk.pl>
References: <1306542839-5688-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36219 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1E1JAj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 May 2011 05:00:39 -0400
In-Reply-To: <1306542839-5688-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>

On Saturday, May 28, 2011, Kevin Hilman wrote:
> Some platforms wish to implement their PM core suspend code as
> modules.  To do so, these functions need to be exported to modules.

Hmm.  What happens if the module is not loaded and the user attempts to
suspend?

Rafael


> Reported-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies against v2.6.39
> 
>  kernel/power/suspend.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 6275970..eca495d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
>  	suspend_ops = ops;
>  	mutex_unlock(&pm_mutex);
>  }
> +EXPORT_SYMBOL(suspend_set_ops);
>  
>  bool valid_state(suspend_state_t state)
>  {
> @@ -65,6 +66,7 @@ int suspend_valid_only_mem(suspend_state_t state)
>  {
>  	return state == PM_SUSPEND_MEM;
>  }
> +EXPORT_SYMBOL(suspend_valid_only_mem);
>  
>  static int suspend_test(int level)
>  {
> 

