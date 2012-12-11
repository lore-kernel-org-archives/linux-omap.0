From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
Date: Tue, 11 Dec 2012 13:30:58 -0500 (EST)
Message-ID: <20121211.133058.2238010228178961245.davem@davemloft.net>
References: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, s.hauer@pengutronix.de
List-Id: linux-omap@vger.kernel.org


You cannot do this.

After your changes the driver no longer does any TX flow control.

It never stops the TX queue and never wakes it up later.

It just drops packets on the floor when it runs out of descriptors.

This breaks everything, and in particular packet schedulers and
TCP.

I'm not applying this.
