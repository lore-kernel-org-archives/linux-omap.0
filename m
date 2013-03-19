From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/23] ARM: OMAP2+: Adapt to ehci-omap changes for
 3.10
Date: Tue, 19 Mar 2013 11:37:36 -0700
Message-ID: <20130319183736.GG16413@atomide.com>
References: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

* Roger Quadros <rogerq@ti.com> [130315 08:20]:
> Hi Tony,
> 
> These patches provide the SoC side code required to support
> the changes in the OMAP USB Host drivers done in [1], [2] & [3].
> 
> Device tree support is added for Beagleboard and Panda.
> 
> NOTE: The first patch needs to be shared between the
> OMAP tree and Felipe's USB tree.

Do you want to put the platform_data header changes alone
into some immutable branch or want me to do it?

Regards,

Tony
