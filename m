From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Enhancements to twl4030 phy to support better
 charging.
Date: Tue, 24 Feb 2015 12:46:33 -0800
Message-ID: <20150224204632.GK11056@atomide.com>
References: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224033730.31400.78200.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neilb@suse.de> [150223 19:45]:
> Hi,
>  the following 4 patches make some improvements to the twl4030
>  phy.  Together with some other patches I have for twl4030_charger,
>  they allow for better automatic control of charging.
> 
>  In particular, the status of the ID pin is assessed and the
>  result in communicated to the charger drivers.
>  There is also support for conveying the max current negotiated by a
>  host to the charger.
> 
> Comments most welcome.

Looks good to me, for the whole series, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
