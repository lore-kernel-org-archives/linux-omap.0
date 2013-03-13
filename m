From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 12/13] USB: ehci-omap: Fix detection in HSIC mode
Date: Wed, 13 Mar 2013 10:30:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1303131029590.1705-100000@iolanthe.rowland.org>
References: <1363180483-10612-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363180483-10612-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 13 Mar 2013, Roger Quadros wrote:

> Move PHY initialization until after EHCI initialization is
> complete, instead of initializing the PHYs first, shutting
> them down again, and then initializing them a second time.
> 
> This fixes HSIC device detection.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> CC: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
