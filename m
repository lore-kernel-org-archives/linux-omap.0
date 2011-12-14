From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 09:31:53 -0800
Message-ID: <20111214173152.GY32251@atomide.com>
References: <1323877279-10275-1-git-send-email-vladimir.zapolskiy@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323877279-10275-1-git-send-email-vladimir.zapolskiy@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com> [111214 07:09]:
> This change adds initialization of TSC2005 touchscreen controller found on Nokia
> RX-51 board.
> 
> The change is taken from MeeGo kernel adaptation for Nokia N900, it repeats the
> work of Aaro Koskinen and Mika Laitio, the original discussion is at
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html

We already have commit 3dad5356aa47097cf67027cf0a07298b4f5baef6
queued up in linux-omap board branch. Can you please make this
and incremental patch to that one? Looks like you got some additional
changes like the muxing of the pins.

Regards,

Tony
