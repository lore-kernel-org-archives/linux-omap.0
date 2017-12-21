From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: Some am43x fixes
Date: Thu, 21 Dec 2017 06:58:17 -0800
Message-ID: <20171221145817.GO3875@atomide.com>
References: <20171215171643.8345-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171215171643.8345-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [171215 09:19]:
> Hi,
> This series has two fixes for am43x based platforms. First patch disables OPP50
> on am437x-idk-evm which the board supply does not support. Second patch is for
> am43x-epos-evm and adds dcdc2 regulator as the missing cpu0-supply which
> enables CPUFreq on this platform.

Applying both into omap-for-v4.16/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
