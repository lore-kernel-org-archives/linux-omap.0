From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: board-omap3evm: add required smsc911x regulators
Date: Fri, 10 Feb 2012 09:40:47 -0800
Message-ID: <20120210174046.GQ1426@atomide.com>
References: <1328738812-26755-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328738812-26755-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <matt@ohporter.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Matt Porter <matt@ohporter.com> [120208 13:35]:
> This fixes smsc911x support on omap3evm that has been broken since
> the smsc911x driver was updated to require the existence of vdd33a
> and vddvario supplies.

Great. Few comments:

1. Could you please include the smsc911x commit and subject here too
   so it clearly shows the regression?

2. Also, why don't you add this fixed regulator to gpmc-smsc911.c?

That way it gets fixed for other too, like zoom2/3.

Regards,

Tony
