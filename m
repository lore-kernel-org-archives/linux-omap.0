From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/3] driver: net: ethernet: cpsw: implement ethtool get/set phy setting
Date: Thu, 07 Mar 2013 14:24:15 +0100
Message-ID: <8762135on4.fsf@dell.be.48ers.dk>
References: <1362659421-11884-1-git-send-email-mugunthanvnm@ti.com>
	<1362659421-11884-2-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1362659421-11884-2-git-send-email-mugunthanvnm@ti.com>
	(Mugunthan V. N.'s message of "Thu, 7 Mar 2013 18:00:19 +0530")
Sender: netdev-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

>>>>> "M" == Mugunthan V N <mugunthanvnm@ti.com> writes:

 M> This patch implements get/set of the phy settings via ethtool apis
 M> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
 M> ---
 M>  Documentation/devicetree/bindings/net/cpsw.txt |    3 +++
 M>  drivers/net/ethernet/ti/cpsw.c                 |   32 ++++++++++++++++++++++++
 M>  include/linux/platform_data/cpsw.h             |    1 +
 M>  3 files changed, 36 insertions(+)

 M> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
 M> index ecfdf75..8d61300 100644
 M> --- a/Documentation/devicetree/bindings/net/cpsw.txt
 M> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
 M> @@ -20,6 +20,7 @@ Required properties:
 M>  - cpts_clock_shift	: Denominator to convert input clock ticks into nanoseconds
 M>  - phy_id		: Specifies slave phy id
 M>  - mac-address		: Specifies slave MAC address
 M> +- ethtool-active-slave	: Specifies the slave to use for ethtool command

That again sounds like something Linux specific rather than a hardware
property.

It would be good if all these special things (dual emac mode, vlan
handling, switching) could be handled using the existing kernel
(bridging/vlan) infrastructure, and the driver always just exposing 2
network interfaces instead of these configuration properties.

-- 
Bye, Peter Korsgaard
