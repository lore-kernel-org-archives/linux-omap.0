From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Fix a division by zero
Date: Tue, 23 Sep 2014 14:58:31 -0700
Message-ID: <20140923215831.GB651@kroah.com>
References: <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 23, 2014 at 09:54:38PM +0200, Frans Klaver wrote:
> Hi Greg,
> 
> Here's a couple of patches that fix a divison by zero in omap-serial.c. One's a
> cleanup, the other the actual fix.

So both would be needed to be backported to stable kernels?  Why not
just do the fix first, then the cleanup afterward, to make backporting
easier?

thanks,

greg k-h
