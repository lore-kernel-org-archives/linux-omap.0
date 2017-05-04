From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Thu, 4 May 2017 12:40:34 -0700
Message-ID: <20170504194034.GA3489@atomide.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170503105645.26759-5-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170503105645.26759-5-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170503 04:00]:
> With the port_window support in DMAengine and the sDMA driver we can
> convert the driver to DMAengine.

Actually looks like this patch still has some issues.. Pinging
the n8x0 with for example ping -s1 causes things to stop working.

This is when using only with the async gpmc access as the sync
gpmc access seems to have a regression not related to this series.
I'll try to track down that sync gpmc issue as that most likely
hints to something being wrong in the gpmc code in general.

Regards,

Tony
