From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCHv2 1/2] drivers: net: davinci_mdio: remove busy loop on
 wait user access
Date: Thu, 10 Aug 2017 16:40:53 +0200
Message-ID: <20170810144053.GE24790@lunn.ch>
References: <1502351267-23841-1-git-send-email-muvarov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502351267-23841-1-git-send-email-muvarov@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Max Uvarov <muvarov@gmail.com>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 10, 2017 at 10:47:46AM +0300, Max Uvarov wrote:
> Polling 14 mdio devices on single mdio bus eats 30% of 1Ghz cpu time
> due to busy loop in wait(). Add small delay to relax cpu.

Hi Max

Please include a cover note when you have multiple patches in a
series.

With 14 devices, it makes sense to swap to using PHY interrupts if you
can. That should prevent the PHY state machine polling the PHYs every
second.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
