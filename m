From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw: fix runtime pm while
 add/del reserved vid
Date: Sat, 11 Aug 2018 09:39:24 -0700 (PDT)
Message-ID: <20180811.093924.1353904230476587999.davem@davemloft.net>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 10 Aug 2018 15:47:07 +0300

> Here 2 not critical fixes for:
> - vlan ale table leak while error if deleting vlan (simplifies next fix)
> - runtime pm while try to set reserved vlan

Series applied, thank you.
