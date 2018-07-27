From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: replace
 unnecessarily macroses on functions
Date: Fri, 27 Jul 2018 23:09:14 +0200
Message-ID: <20180727210914.GB19398@lunn.ch>
References: <20180727204958.23658-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727204958.23658-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, joe@perches.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 27, 2018 at 11:49:58PM +0300, Ivan Khoronzhuk wrote:
> Replace ugly macroses on functions.
> 
> v2..v1:
>  - removed inline for cpsw_src_port_detect()

Hi Ivan

Comments like this should be placed under the ---. Otherwise the
appear in the commit message.

	 Andrew
