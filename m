From: David Miller <davem@davemloft.net>
Subject: Re: [PATCHv2 1/2] drivers: net: davinci_mdio: remove busy loop on
 wait user access
Date: Fri, 11 Aug 2017 14:24:29 -0700 (PDT)
Message-ID: <20170811.142429.299530602332181718.davem@davemloft.net>
References: <1502351267-23841-1-git-send-email-muvarov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1502351267-23841-1-git-send-email-muvarov@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: muvarov@gmail.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

From: Max Uvarov <muvarov@gmail.com>
Date: Thu, 10 Aug 2017 10:47:46 +0300

> Polling 14 mdio devices on single mdio bus eats 30% of 1Ghz cpu time
> due to busy loop in wait(). Add small delay to relax cpu.
> 
> Signed-off-by: Max Uvarov <muvarov@gmail.com>

Applied to net-next.
