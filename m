From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw: fix susp/resume
Date: Fri, 10 Feb 2017 00:54:24 +0200
Message-ID: <20170209225423.GA15853@khorivan>
References: <1486598856-3512-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <20170209.172126.155005439329995220.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170209.172126.155005439329995220.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mugunthanvnm@ti.com, grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, AStarikovskiy@topcon.com
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 09, 2017 at 05:21:26PM -0500, David Miller wrote:
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Date: Thu,  9 Feb 2017 02:07:34 +0200
> 
> > These two patches fix suspend/resume chain.
> 
> Patch 2 doesn't apply cleanly to the 'net' tree, please
> respin this series.

Strange, I've just checked it on net-next/master, it was applied w/o any
warnings.
