From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: very confusing config around OHCI_OMAP3_HCD
Date: Thu, 3 May 2018 12:28:38 -0700
Message-ID: <20180503192838.GY98604@atomide.com>
References: <20180503192510.GB32572@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503192510.GB32572@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180503 19:27]:
> Hi!
> 
> For power management experiments, I tried
> 
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_OMAP3=m
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> 
> and could not find resulting .ko.
> 
> Help text says:
> 
> CONFIG_USB_OHCI_HCD_OMAP3:
> 
> This option is deprecated now and the driver was removed, use
> USB_OHCI_HCD_PLATFORM instead.
> 
> Enables support for the on-chip OHCI controller on
> OMAP3 and later chips.
> 
> Which may partly explain it. But if the option no longer does
> anything, why keep it? Certainly second part is confusing if option is
> NOP...

Yeah it's ohci-platform now, I think we decided to keep the old one
around to avoid breaking people's .config files for booting rather
than silently fail.

Regards,

Tony
