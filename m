From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH  v2 02/13] net: ethernet: ti: allow cpts to be built
 separately
Date: Tue, 29 Nov 2016 10:37:50 +0100
Message-ID: <20161129093750.GA3110@localhost.localdomain>
References: <20161128230337.6731-1-grygorii.strashko@ti.com>
 <20161128230337.6731-3-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161128230337.6731-3-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Wingman Kwok <w-kwok2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 28, 2016 at 05:03:26PM -0600, Grygorii Strashko wrote:

> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c

> +EXPORT_SYMBOL_GPL(cpts_unregister);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("TI CPTS ALE driver");

ALE?

Also, MODULE_AUTHOR (that's me) is missing.

Thanks,
Richard
