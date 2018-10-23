From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: unsync mcast
 entries while switch promisc mode
Date: Mon, 22 Oct 2018 20:20:47 -0700 (PDT)
Message-ID: <20181022.202047.2168925005944098472.davem@davemloft.net>
References: <20181022185136.8215-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022185136.8215-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Mon, 22 Oct 2018 21:51:36 +0300

> After flushing all mcast entries from the table, the ones contained in
> mc list of ndev are not restored when promisc mode is toggled off,
> because they are considered as synched with ALE, thus, in order to
> restore them after promisc mode - reset syncing info. This fix
> touches only switch mode devices, including single port boards
> like Beagle Bone.
> 
> Fixes: commit 5da1948969bc
> ("net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update")
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
