From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHV3 0/4] The series attempts to do the following
Date: Thu, 21 Jul 2011 08:32:49 -0700
Message-ID: <877h7babtq.fsf@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311256381-25548-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Thu, 21 Jul 2011 19:22:57 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> - The reset should not be done in the driver 
>   have support for the same.
> - Remove the sysc register access in the driver.
> - Restore the context only if the context is lost.

Hello,

Can you base the next version of this on my wip/i2c branch[1] which has a
couple other misc. cleanup patches that will be queued for v3.2.

Thanks,

Kevin


[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git wip/i2c
