From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: cpcap-usb: only build if CPCAP is enabled
Date: Wed, 12 Jul 2017 23:23:56 -0700
Message-ID: <20170713062356.GD16509@atomide.com>
References: <20170712153022.25910-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170712153022.25910-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:31]:
> CPCAP phy can only be used with CPCAP MFD, so let's add
> a dependency. There is no need to ask for it on e.g. x86
> systems. Since nobody complained about compilation errors
> in a couple of weeks it is safe to ignore the dependency
> for COMPILE_TEST, though.
> 
> Also enable CPCAP phy support by default if the main
> CPCAP driver is enabled.

Acked-by: Tony Lindgren <tony@atomide.com>
