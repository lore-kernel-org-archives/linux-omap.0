From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Tue, 25 Jul 2017 01:55:17 -0700
Message-ID: <20170725085517.GQ10026@atomide.com>
References: <20170724095201.21601-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724095201.21601-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [170724 02:53]:
> Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> device with an active child"), which went into 4.10, it is no longer
> permitted to set RPM_SUSPENDED state for a device with active children
> (unless power.ignore_children is set).
> 
> This specifically means that the attempts to do just that from the omap
> pm-domain suspend_noirq callback have since been failing whenever a
> child is active, for example:
> 
>   am335x-usb-childs 47400000.usb: runtime PM trying to suspend
>     device but active child
> 
> Silence this warning by dropping the broken pm_runtime_set_suspended()
> call from the omap suspend_noirq callback along with the redundant
> pm_runtime_set_active() in resume_noirq.

With this things still work for me for my PM tests on omap3. Device
suspends and resumes just fine hitting off mode during suspend.

Regards,

Tony
