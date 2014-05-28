From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v3 1/5] sc_phy:SmartCard(SC) PHY interface to SC
 controller
Date: Wed, 28 May 2014 11:53:34 -0700
Message-ID: <20140528185334.GA30763@kroah.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-2-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401267437-22489-2-git-send-email-satish.patel-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 28, 2014 at 02:27:13PM +0530, Satish Patel wrote:
> SmartCard controller uses this interface to communicate with
> SmartCard via PHY
> 
> Some SmartCard PHY has multiple slots for cards.
> This inerface also enables controller to communicate
> with one or more SmartCard connected over phy.
> 
> interface structure includes following APIs
> - set/get config
> - activate/deactivate smart card
> - warm reset
> - register_notify (for card insert/remove/overheat)
> - unregister_notify
> 
> Signed-off-by: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/sc_phy.txt |  171 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sc_phy.h   |  136 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 307 insertions(+)
>  create mode 100644 Documentation/sc_phy.txt
>  create mode 100644 include/linux/sc_phy.h

These are .h files, but where is the "api" functions that use
these structures defined at?

confused,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
