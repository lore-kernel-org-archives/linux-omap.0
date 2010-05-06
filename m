From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4 v2] ks8851: companion eeprom access through ethtool
Date: Thu, 06 May 2010 00:20:24 -0700 (PDT)
Message-ID: <20100506.002024.191394263.davem@davemloft.net>
References: <1273085155-1260-1-git-send-email-s-jan@ti.com>
	<1273085155-1260-4-git-send-email-s-jan@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1273085155-1260-4-git-send-email-s-jan@ti.com>
Sender: netdev-owner@vger.kernel.org
To: s-jan@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, x0066660@ti.com, ben-linux@fluff.org, Tristram.Ha@micrel.com
List-Id: linux-omap@vger.kernel.org

From: Sebastien Jan <s-jan@ti.com>
Date: Wed,  5 May 2010 20:45:54 +0200

> Accessing ks8851 companion eeprom permits modifying the ks8851 stored
> MAC address.
> 
> Example how to change the MAC address using ethtool, to set the
> 01:23:45:67:89:AB MAC address:
> $ echo "0:AB8976452301" | xxd -r > mac.bin
> $ sudo ethtool -E eth0 magic 0x8870 offset 2 < mac.bin
> 
> Signed-off-by: Sebastien Jan <s-jan@ti.com>

Applied.
