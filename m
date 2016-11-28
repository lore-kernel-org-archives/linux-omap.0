From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4] cpsw: ethtool: add support for getting/setting EEE
 registers
Date: Mon, 28 Nov 2016 16:23:20 -0500 (EST)
Message-ID: <20161128.162320.1497118051889266063.davem@davemloft.net>
References: <1480322493-25308-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1480322493-25308-1-git-send-email-yegorslists@googlemail.com>
Sender: netdev-owner@vger.kernel.org
To: yegorslists@googlemail.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, mugunthanvnm@ti.com
List-Id: linux-omap@vger.kernel.org

From: yegorslists@googlemail.com
Date: Mon, 28 Nov 2016 09:41:33 +0100

> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Add the ability to query and set Energy Efficient Ethernet parameters
> via ethtool for applicable devices.
> 
> This patch doesn't activate full EEE support in cpsw driver, but it
> enables reading and writing EEE advertising settings. This way one
> can disable advertising EEE for certain speeds.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Acked-by: Rami Rosen <roszenrami@gmail.com>
> ---
> Changes:
> 	v4: respine against net-next (David Miller)
> 	v3: explain what features will be available with this patch (Florian Fainelli)
> 	v2: make routines static (Rami Rosen)

Applied, thank you.
