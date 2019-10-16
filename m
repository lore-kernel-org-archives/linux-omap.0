From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] davinci_cpdma: make cpdma_chan_split_pool static
Date: Tue, 15 Oct 2019 20:56:28 -0700 (PDT)
Message-ID: <20191015.205628.1701790705408520886.davem@davemloft.net>
References: <20191015161558.18506-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191015161558.18506-1-ben.dooks@codethink.co.uk>
Sender: netdev-owner@vger.kernel.org
To: ben.dooks@codethink.co.uk
Cc: linux-kernel@lists.codethink.co.uk, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Date: Tue, 15 Oct 2019 17:15:58 +0100

> The cpdma_chan_split_pool() function is not used outside of
> the driver, so make it static to avoid the following sparse
> warning:
> 
> drivers/net/ethernet/ti/davinci_cpdma.c:725:5: warning: symbol 'cpdma_chan_split_pool' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
