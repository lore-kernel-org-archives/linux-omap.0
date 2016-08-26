From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: dra7: workaround silicon limitation i845
Date: Fri, 26 Aug 2016 08:28:54 -0700
Message-ID: <20160826152854.l5kc2nuaxxomffi4@atomide.com>
References: <1471942661-1728-1-git-send-email-rogerq@ti.com>
 <1471942661-1728-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471942661-1728-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, robh+dt@kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [160823 01:58]:
> From: Sekhar Nori <nsekhar@ti.com>
> 
> Silicon limitation i845 documents how to cope with false
> disconnection condition on USB2 PHY. Reference: AM572x
> silicon errata document SPRZ429H, revised January 2016.
> 
> Using compatible "ti,dra7x-usb2" enables the recommended
> software workaround for this issue. Use it for USB1 PHY.
> 
> The workaround is already in place for USB2 PHY.

Picking this patch into omap-for-v4.9/dt branch.

Regards,

Tony
