From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Date: Mon, 26 Nov 2018 03:27:11 +0100
Message-ID: <20181126022711.GD32164@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125234315.28313-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> 
> Unfortunately, this breaks some industrial automation protocols, as
> reported by TI customers [1], which can work only with min TX packet size
> from 60 byte (ecluding FCS).

Hi Grygorii

excluding...

> Hence, introduce module boot parameter "tx_packet_min" to allow configure
> min TX packet size at boot time.

Module parameters are generally not liked.

What actually happens here with this lower limit? Does the hardware
send runt packets? Does the protocol actually require runt packets?

I'm just wondering if the module parameter can be avoided by setting
this as the default. But we need to ensure ARP packets, which are
smaller than the minimum MTU are correctly padded.

Thanks
	Andrew
