From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY
 clock"
Date: Wed, 9 Oct 2013 08:15:23 -0700
Message-ID: <20131009151522.GA8313@atomide.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
 <1381226799-29158-6-git-send-email-rogerq@ti.com>
 <52550180.1000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52550180.1000506@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [131009 00:19]:
> Hi Tony,
> 
> On 10/08/2013 01:06 PM, Roger Quadros wrote:
> > This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.
> > 
> > The proper clock reference is provided in device tree so we
> > no longer need this.
> 
> Could you please Ack this one? I think it is best if it goes through Benoit's tree.

I could queue this into my board removal series that will be
based on Benoit's branch if that works for you. And this
also seems to depend on the omap-for-v3.13/quirk branch
that moves all the legacy pdata handling into pdata-quirks.c.

The reason for this is that we want to keep the .dts changes
completely separate from the code changes to avoid dependencies
that cause pointless merge conflicts. And the .dts files will
be moved to live in a separate repo soonish, so it's good
to be prepared for that.

Regards,

Tony
