From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: correct .ndo_open
 error path
Date: Tue, 28 May 2019 20:48:05 +0300
Message-ID: <20190528174803.GA3233@khorivan>
References: <20190528123352.21505-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528123352.21505-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Please ignore this version, I've sent version 2 that do the same but is more
adjustable for later on changes and based on usage counter.

-- 
Regards,
Ivan Khoronzhuk
