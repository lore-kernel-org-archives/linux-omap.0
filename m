From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] USB: OHCI: omap: remove useless extern declaration
Date: Mon, 5 Dec 2016 15:10:45 +0100
Message-ID: <20161205141045.GB29165@kroah.com>
References: <1480735523-23950-1-git-send-email-csmanjuvijay@gmail.com>
 <1480735523-23950-3-git-send-email-csmanjuvijay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480735523-23950-3-git-send-email-csmanjuvijay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: csmanjuvijay@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 03, 2016 at 03:25:22AM +0000, csmanjuvijay@gmail.com wrote:
> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> Remove usb_disabled() and ocpi_enable() extern declaration
> as it is already declared as EXPORT_SYMBOL_GPL declaration.

Same here, EXPORT_SYMBOL* doesn't matter for stuff like this.

thanks,

greg k-h
