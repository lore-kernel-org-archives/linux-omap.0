From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2 15/15] ethernet: ti: davinci_emac: add missing
 of_node_put after calling of_parse_phandle
Date: Mon, 1 Aug 2016 13:58:20 +0530
Message-ID: <b2d0d3a2-acf9-c151-9810-0f3045f6cac3@ti.com>
References: <1470034963-30506-1-git-send-email-peter.chen@nxp.com>
 <1470034963-30506-16-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1470034963-30506-16-git-send-email-peter.chen@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, vbridger@opensource.altera.com, isubramanian@apm.com, kchudgar@apm.com, yisen.zhuang@huawei.com, salil.mehta@huawei.com, thomas.petazzoni@free-electrons.com, sergei.shtylyov@cogentembedded.com, peppe.cavallaro@st.com, alexandre.torgue@st.com, tremyfr@gmail.com, wxt@rock-chips.com, arnd@arndb.de, david.daney@cavium.com, huangdaode@hisilicon.com, jszhang@marvell.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

+omap ML

On Monday 01 August 2016 12:32 PM, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
