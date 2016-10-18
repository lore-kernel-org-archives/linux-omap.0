From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 0/4] add support for impedance control for TI
 dp83867 phy and fix 2nd ethernet on dra72 rev C evm
Date: Tue, 18 Oct 2016 10:42:53 -0400 (EDT)
Message-ID: <20161018.104253.1412536252154725850.davem@davemloft.net>
References: <20161018112020.30273-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161018112020.30273-1-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, tony@atomide.com, linux@armlinux.org.uk, f.fainelli@gmail.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Tue, 18 Oct 2016 16:50:16 +0530

> Add support for configurable impedance control for TI dp83867
> phy via devicetree. More documentation in [1].
> CPSW second ethernet is not working, fix it by enabling
> impedance configuration on the phy.

Series applied to net-next, thanks.
