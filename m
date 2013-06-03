From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] USB: PHY: Improve PHY selection logic
Date: Mon, 3 Jun 2013 10:47:09 -0700
Message-ID: <20130603174709.GA11059@kroah.com>
References: <1369999743-11758-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369999743-11758-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, arnd@arndb.de, adrienverge@gmail.com, kishon@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 31, 2013 at 02:29:01PM +0300, Roger Quadros wrote:
> Hi,
> 
> Improve Kconfig so that the relevant PHY driver can be explicitely
> selected by the controller driver instead of relying on the user
> to do so.
> 
> Detailed description in patch 1.

Felipe needs to take these, not I.

thanks,

greg k-h
