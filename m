From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/5] TI Ethernet driver warnings fixes
Date: Mon, 21 May 2018 16:18:32 -0400 (EDT)
Message-ID: <20180521.161832.85473627565332598.davem@davemloft.net>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, akpm@linux-foundation.org, j-keerthy@ti.com, bhumirks@gmail.com, hernan@vanguardiasur.com.ar, richardcochran@gmail.com, lukas@wunner.de, robh@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 May 2018 11:45:50 -0700

> Hi all,
> 
> This patch series attempts to fix properly the warnings observed with turning
> on COMPILE_TEST and TI Ethernet drivers on 64-bit hosts.
> 
> Since I don't have any of this hardware, please review carefully for possible
> breakage!

These seem extremely safe to me, and since I have a vested interest in seeing
these warning disappear from my tree....

Series applied, thanks :-)
