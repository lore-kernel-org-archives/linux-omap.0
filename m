From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_cpdma: use idled
 submit
Date: Sun, 16 Jun 2019 14:03:41 -0700 (PDT)
Message-ID: <20190616.140341.1206535816113380121.davem@davemloft.net>
References: <20190615110132.6594-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190615110132.6594-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Sat, 15 Jun 2019 14:01:32 +0300

> While data pass suspend, reuse of rx descriptors can be disabled using
> channel state & lock from cpdma layer. For this, submit to a channel
> has to be disabled using state != "not active" under lock, what is done
> with this patch. The same submit is used to fill rx channel while
> ndo_open, when channel is idled, so add idled submit routine that
> allows to prepare descs for the channel. All this simplifies code and
> helps to avoid dormant mode usage and send packets only to active
> channels, avoiding potential race in later on changes. Also add missed
> sync barrier analogically like in other places after stopping tx
> queues.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
