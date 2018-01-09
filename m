From: Keerthy <j-keerthy@ti.com>
Subject: Re: AM43x boot broken on linux-next
Date: Tue, 9 Jan 2018 15:22:50 +0530
Message-ID: <b79af9ad-e238-50ec-ef85-62957b267de8@ti.com>
References: <bf1fc3d2-b882-7850-4afd-c1e753e2a1a7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <bf1fc3d2-b882-7850-4afd-c1e753e2a1a7@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 09 January 2018 02:03 PM, Keerthy wrote:
> Hi,

Adding netdev@vger.kernel.org

> 
> Seems like AM437x boot is broken on latest linux-next.
> Log here:
> 
> https://pastebin.ubuntu.com/26351906/
> 
> "Unable to handle kernel paging request at virtual address 000013e8
> [    2.367045] pgd = c0350bf7
> [    2.370019] [000013e8] *pgd=00000000
> [    2.373823] Internal error: Oops: 5 [#1] SMP ARM
> [    2.378709] Modules linked in:
> [    2.381949] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.15.0-rc6-next-20180108-38410-g895c0dd #4
> [    2.391242] Hardware name: Generic AM43 (Flattened Device Tree)
> [    2.397523] PC is at phy_attached_print+0xc/0x10c
> [    2.402506] LR is at cpsw_slave_open+0x16c/0x258"
> 
> Regards,
> Keerthy
> 
