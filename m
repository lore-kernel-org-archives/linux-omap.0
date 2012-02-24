From: Igor Grinberg <grinberg@compulab.co.il>
Subject: ARM: OMAP: patches for stable
Date: Fri, 24 Feb 2012 10:43:25 +0200
Message-ID: <4F474DAD.1030302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg,

There are several patches already in mainline, that should be also applied to stable:

40410715 (ARM: omap: fix oops in drivers/video/omap2/dss/dpi.c)				[3.2-stable]
d980e0f8 (ARM: omap: fix oops in arch/arm/mach-omap2/vp.c when pmic is not found)	[3.2-stable]

Can these, please be applied to stable?

Thanks

-- 
Regards,
Igor.
