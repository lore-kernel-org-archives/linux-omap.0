From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: correct .ndo_open
 error path
Date: Wed, 29 May 2019 21:50:32 -0700 (PDT)
Message-ID: <20190529.215032.862998826382261504.davem@davemloft.net>
References: <20190528174519.7370-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528174519.7370-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Tue, 28 May 2019 20:45:19 +0300

> It's found while review and probably never happens, but real number
> of queues is set per device, and error path should be per device.
> So split error path based on usage_count.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied, thanks.
