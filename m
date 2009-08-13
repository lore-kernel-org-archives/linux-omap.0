From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 10/10] OMAP: PM: Added suspend target state control to
 debugfs for OMAP3
Date: Thu, 13 Aug 2009 13:42:08 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A78398A@dlee02.ent.ti.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-8-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-9-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-10-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-11-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250182359-18830-11-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, "linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Kevin,

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Kevin Hilman
> Sent: Thursday, August 13, 2009 11:53 AM
> To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org; linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tero Kristo
> Subject: [PATCH 10/10] OMAP: PM: Added suspend target state control to
> debugfs for OMAP3
> 
> From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Target state can be read / programmed via files under:
>   [debugfs]/pm_debug/[pwrdm]/suspend
> 
> Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
>  arch/arm/mach-omap2/pm-debug.c |   31 +++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/pm.h       |    3 +++
>  arch/arm/mach-omap2/pm34xx.c   |   24 ++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 2 deletions(-)
>  mode change 100755 => 100644 arch/arm/mach-omap2/pm-debug.c
> 
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-
> debug.c
> old mode 100755
> new mode 100644

And here one 755 mode change mistake in 6/10 is fixed... So, you'll need to refresh this aswell I guess...

Regards,
Sergio
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
