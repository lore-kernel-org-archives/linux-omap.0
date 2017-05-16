From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: dra7x-evm: Enable dual-role mode for USB1
Date: Tue, 16 May 2017 09:24:48 -0700
Message-ID: <20170516162447.GI31418@atomide.com>
References: <1491916575-16023-1-git-send-email-rogerq@ti.com>
 <1491916575-16023-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491916575-16023-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [170411 06:19]:
> USB1 port is micro-AB type and can function as peripheral
> as well as host. Enable dual-role mode for USB1.
> 
> We don't want to use the OTG controller block on this
> platform as it limits host mode to high-speed. Instead
> we rely on extcon framework to give us ID events for
> dual-role mode detection.

Applying into omap-for-v4.13/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
