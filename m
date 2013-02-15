From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] drivers: net: davinci_cpdma: acknowledge
 interrupt properly
Date: Fri, 15 Feb 2013 15:05:06 -0500 (EST)
Message-ID: <20130215.150506.499818568035818118.davem@davemloft.net>
References: <1360866406-17261-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1360866406-17261-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Thu, 14 Feb 2013 23:56:46 +0530

> +enum {
> +	CPDMA_EOI_RX_THRESH = 0,
> +	CPDMA_EOI_RX,
> +	CPDMA_EOI_TX,
> +	CPDMA_EOI_MISC,
> +};

Do not use enumerations for hardware register values, which must be
exact, otherwise you are potentially going to succumb to the vagaries
of C language enumeration value assignment.
