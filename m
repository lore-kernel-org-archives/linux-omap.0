From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw fix mcast packet lost
Date: Mon, 15 Oct 2018 22:21:42 -0700 (PDT)
Message-ID: <20181015.222142.1836051794612738861.davem@davemloft.net>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 12 Oct 2018 18:28:13 +0300

> The patchset omits redundant refresh of mcast address table and
> prevents mcast packet lost.
> 
> Based on net-next/master
> tested on am572x evm

Series applied.
