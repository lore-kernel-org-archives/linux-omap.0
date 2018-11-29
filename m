From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Date: Thu, 29 Nov 2018 12:24:41 +0000
Message-ID: <59c91a27bb5b473fa5e1139016d3d825@AcuMS.aculab.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181125234315.28313-1-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Grygorii Strashko' <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko
> Sent: 25 November 2018 23:43
> 
> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> 
> Unfortunately, this breaks some industrial automation protocols, as
> reported by TI customers [1], which can work only with min TX packet size
> from 60 byte (ecluding FCS).

VLAN packets have the same minimal size as normal packets.
So they should (probably must) only be padded to 64 bytes (including the CRC).
Any hardware that strips a VLAN header would then need to add an extra
4 bytes of padding.

You can't assume that padding that makes an ethernet frame be longer
than 64 bytes (inc CRC) will be ignored by the receiving system.

So whatever make you think that 68 bytes was required is itself broken.

While most IP implementations will ignore extra padding this isn't
true of all protocols or implementations.
Unfortunately the fact that it is silently ignored causes the bugs
to be hidden.

We've recently discovered that some configurations of a VM system
cause all ethernet packets be padded to even length.
And yes, it broke things....

One of the very early ethernet chipsets could only transmit even
length packets - but I suspect they are all now in silicon heaven.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
