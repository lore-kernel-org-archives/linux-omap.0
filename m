From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/5] ARM: dts: OMAP2+: Enable USB dual-role on
 supported boards
Date: Tue, 21 Jul 2015 03:54:33 -0700
Message-ID: <20150721105433.GZ17550@atomide.com>
References: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150708 03:45]:
> Hi,
> 
> Enables dual-role feaure on supported boards.
> 
> Depends on
> [1] - core USB DRD support - http://thread.gmane.org/gmane.linux.kernel/1991413
> [2] - dwc3 DRD support - http://thread.gmane.org/gmane.linux.usb.general/127890

Is this series safe to apply separately actually? Adding the
interrupts and the mode name may not be a problem without
the related driver changes?

Regards,

Tony
