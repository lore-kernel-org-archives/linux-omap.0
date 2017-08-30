From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ti: cpsw-common: dont print error if
 ti_cm_get_macid() fails
Date: Wed, 30 Aug 2017 10:09:22 -0700 (PDT)
Message-ID: <20170830.100922.2045071081491642186.davem@davemloft.net>
References: <423afc6874d8911615c4df941957067aebfc09dd.1504080198.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <423afc6874d8911615c4df941957067aebfc09dd.1504080198.git.nsekhar@ti.com>
Sender: netdev-owner@vger.kernel.org
To: nsekhar@ti.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, tony@atomide.com, aford173@gmail.com
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>
Date: Wed, 30 Aug 2017 13:37:13 +0530

> It is quite common for ti_cm_get_macid() to fail on some of the
> platforms it is invoked on. They include any platform where
> mac address is not part of SoC register space.
> 
> On these platforms, mac address is read and populated in
> device-tree by bootloader. An example is TI DA850.
> 
> Downgrade the severity of message to "information", so it does
> not spam logs when 'quiet' boot is desired.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied, thank you.
