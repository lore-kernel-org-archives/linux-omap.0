From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP: PM: formalize idle notifications
Date: Fri, 22 Oct 2010 11:05:53 -0700
Message-ID: <20101022180553.GD17595@atomide.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56885 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0JVSF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 14:05:58 -0400
Content-Disposition: inline
In-Reply-To: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101020 16:22]:
> Currently in the idle path, we have custom function calls into device
> code to handle device specific actions that need to be coordinated CPU
> idle transitions. Rather than continue this ad-hoc method of calling
> device code from the PM core, create a formal way for device/driver
> code to register for idle notifications.
> 
> Idle notifications are done late in the idle path when interrupts are
> disabled, hence use atomic notifier chains.  These notifications will
> also be atomic with respect to CPU idle transitions.

...

> +EXPORT_SYMBOL_GPL(omap_idle_notifier_register);
> +EXPORT_SYMBOL_GPL(omap_idle_notifier_unregister);

Let's rather set this up as a generic framework to avoid adding
more omap specific frameworks to the drivers.

Regards,

Tony
