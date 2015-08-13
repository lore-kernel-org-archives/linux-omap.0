From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 07/13] memory: kill off set_irq_flags usage
Date: Thu, 13 Aug 2015 00:51:05 -0700
Message-ID: <20150813075105.GX4215@atomide.com>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-8-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436711211-18223-8-git-send-email-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, arm@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [150712 07:29]:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.

Applying this one into omap-for-v4.3/soc thanks.

Tony
