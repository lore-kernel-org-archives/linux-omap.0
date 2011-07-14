From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] OMAP4:hwmod: I2C : I2C context restore
Date: Thu, 14 Jul 2011 10:59:19 -0700
Message-ID: <87aacgoia0.fsf@ti.com>
References: <1310661295-3855-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310661295-3855-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Thu, 14 Jul 2011 22:04:55 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Restore of context is not done for OMAP4. This patch 
> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
> hwmod data which activates the restore for OMAP4.
> Currently the OMAP4 does not hit device off still the
> driver may have support for it.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Subject should include 'hwmod data', and fix up the spacing:

OMAP4: hwmod data: I2C: add flag for context restore

Kevin
