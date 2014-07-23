From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/misc/ti-st: Load firmware from ti-connectivity
 directory.
Date: Wed, 23 Jul 2014 16:55:45 -0700
Message-ID: <20140723235545.GA976@kroah.com>
References: <1406027318-26186-1-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406027318-26186-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: pavan_savoy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 22, 2014 at 01:08:38PM +0200, Enric Balletbo i Serra wrote:
> Looks like the default location for TI firmware is inside the ti-connectivity
> directory, to be coherent with other firmware request used by TI drivers, load
> the TIInit firmware from this directory instead of /lib/firmware directly.

Ah, it's this way in the linux-firmware package, I'll go queue this up
now, sorry for the delay.

greg k-h
