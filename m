From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 0/9] use c99 initializers in structures
Date: Sat, 23 Aug 2014 08:21:04 -0700
Message-ID: <20140823152104.GC2074@thin>
References: <1408792831-25615-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408792831-25615-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pwm-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-nfc@lists.01.org, linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 23, 2014 at 01:20:22PM +0200, Julia Lawall wrote:
> These patches add labels in the initializations of structure fields (c99
> initializers).  The complete semantic patch thta makes this change is shown
> below.  This rule ignores cases where the initialization is just 0 or NULL,
> where some of the fields already use labels, and where there are nested
> structures.

I responded to patches 6 and 8 with comments; for the rest (1-5, 7, 9):
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
