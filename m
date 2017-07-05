From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] ARM: pm: add missing types include
Date: Wed, 5 Jul 2017 18:01:00 +0200
Message-ID: <20170705160057.GD17293@xo-6d-61-c0.localdomain>
References: <20170704132542.27644-1-johan@kernel.org>
 <20170704132542.27644-3-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704132542.27644-3-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2017-07-04 15:25:42, Johan Hovold wrote:
> Add missing types.h include to make the suspend header self-contained
> and avoid compilation breakage due to include-directive ordering.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +++ b/arch/arm/include/asm/suspend.h
>  #define __ASM_ARM_SUSPEND_H
>  
> +#include <linux/types.h>
> +
>  struct sleep_save_sp {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
