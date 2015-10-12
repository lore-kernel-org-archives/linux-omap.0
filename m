From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-lilly-a83x: Don't use IRQ level flag for
 a GPIO
Date: Mon, 12 Oct 2015 16:42:05 -0700
Message-ID: <20151012234205.GR23801@atomide.com>
References: <1444123379-1590-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444123379-1590-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151006 02:27]:
> The card detect GPIO is using IRQ_TYPE_LEVEL_LOW in the GPIO flag cells
> but this defined constant is meant to be used for a IRQ and not a GPIO.
> So instead use GPIO_ACTIVE_LOW that seems to be the original intention.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applying into omap-for-v4.4/dt thanks.

Tony
