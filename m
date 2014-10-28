From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
Date: Tue, 28 Oct 2014 08:47:46 +0000
Message-ID: <20141028084745.GY12379@n2100.arm.linux.org.uk>
References: <20141024160845.GM26941@saruman> <20141024190251.GB19377@localhost> <20141024192540.GD11455@saruman> <20141024192948.GE11455@saruman> <20141024193655.GD19377@localhost> <20141024194442.GG11455@saruman> <20141024195532.GF19377@localhost> <20141027162251.d7ff2a5f31917c638d4e47f7@linux-foundation.org> <20141028002552.GX12379@n2100.arm.linux.org.uk> <20141028081616.GL2006@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46885 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752772AbaJ1IsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2014 04:48:04 -0400
Content-Disposition: inline
In-Reply-To: <20141028081616.GL2006@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Lokesh Vutla <lokeshvutla@ti.com>, Guenter Roeck <linux@roeck-us.net>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org

On Tue, Oct 28, 2014 at 09:16:16AM +0100, Johan Hovold wrote:
> It looks like we're soon to be having power-off call chains, with
> configurable priorities, to shut of various parts of the hardware

I really hope that they *don't* get used like that.  I guess this is
what happens when people don't read the code before they decide to
implement something.

All the reboot/power off/halt methods already call into the driver model,
and the driver model then iterates over all bound drivers calling their
"shutdown" method.  So, today, as it has been for years, all device
drivers are notified of system power off.

That's where most device drivers should be cleanly stopping their
hardware.

The only thing which is left is the actual hardware triggering of the
action, and that should be what's done via the notifier.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
