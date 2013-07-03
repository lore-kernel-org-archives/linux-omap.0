From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Wed, 3 Jul 2013 16:06:04 +0300
Message-ID: <51D421BC.9050600@ti.com>
References: <51D28DB9.704@ti.com> <Pine.LNX.4.44L0.1307021302430.1086-100000@iolanthe.rowland.org> <20130703125719.GD15056@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130703125719.GD15056@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, tony@atomide.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/03/2013 03:57 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 02, 2013 at 01:17:58PM -0400, Alan Stern wrote:
>> A PCI-based EHCI controller has two power sources: the core well (which
>> is turned off during suspend) and the auxiliary well (which remains
>> powered).  That's how remote wakeup works; it uses the auxiliary well.
> 
> This, kinda, matches what OMAP tries to do with pad wakeup. Just that
> pad wakeup sits outside of the device itself. Perhaps we could look into
> how PCI handles the aux well and take some inspiration from there.
> 
> Any pointers under drivers/pci/ would be great :-)
> 
>From what I understood, auxiliary well is just a power source, and it keeps
the EHCI controller powered even during suspend.

If that is true then it is different from our situation as we power down the
EHCI controller completely.

cheers,
-roger
