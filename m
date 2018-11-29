From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet size
Date: Thu, 29 Nov 2018 13:05:47 +0000
Message-ID: <CA+V-a8veO--4+hazkm=MAekbQrA+-JUNVjWKW13_0354iUwgKQ@mail.gmail.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com> <20181126022711.GD32164@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126022711.GD32164@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On Mon, Nov 26, 2018 at 2:27 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
> > For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> > 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> > commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> >
> > Unfortunately, this breaks some industrial automation protocols, as
> > reported by TI customers [1], which can work only with min TX packet size
> > from 60 byte (ecluding FCS).
>
> Hi Grygorii
>
> excluding...
>
> > Hence, introduce module boot parameter "tx_packet_min" to allow configure
> > min TX packet size at boot time.
>
> Module parameters are generally not liked.
>
> What actually happens here with this lower limit? Does the hardware
> send runt packets? Does the protocol actually require runt packets?
>
Yes it does send runt packets,  and also get Rx align errors. you can
find the ethtool dump at [1].

[1] https://e2e.ti.com/support/processors/f/791/t/719557?Linux-AM5728-EtherCAT-packets-dropped

Cheers,
--Prabhakar Lad
