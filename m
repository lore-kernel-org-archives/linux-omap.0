From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: davinci_emac: Deduplicate
 bus_find_device() by name matching
Date: Thu, 30 Nov 2017 09:24:44 -0500 (EST)
Message-ID: <20171130.092444.1623604846330363969.davem@davemloft.net>
References: <4cc7d22afdb1d511cef489b3c6b498270bd5caff.1511608500.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4cc7d22afdb1d511cef489b3c6b498270bd5caff.1511608500.git.lukas@wunner.de>
Sender: netdev-owner@vger.kernel.org
To: lukas@wunner.de
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 25 Nov 2017 12:18:19 +0100

> No need to reinvent the wheel, we have bus_find_device_by_name().
> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied.
