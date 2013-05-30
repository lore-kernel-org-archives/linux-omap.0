From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
Date: Thu, 30 May 2013 09:39:17 +0200
Message-ID: <51A70225.50300@ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com> <20130508235404.GX32546@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C320D@DBDE04.ent.ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C5629@DBDE04.ent.ti.com>
 <51A6FEA8.5030704@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C8BCD@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C8BCD@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "zonque@gmail.com" <zonque@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 05/30/2013 09:31 AM, Gupta, Pekon wrote:
>> Sorry, I missed that series.
>>
>> I'm applying it right now.
>>
> No issues.. Please pick newer v4 versions of this series.
> Following are rebased, updated and tested on linux-3.10-rc3
> 
> [PATCH v4,0/3] http://www.spinics.net/lists/linux-omap/msg91165.html
> 
> [PATCH v4,1/3] http://www.spinics.net/lists/linux-omap/msg91166.html
> 
> [PATCH v4,2/3] (please skip this one)
> instead pick http://www.spinics.net/lists/linux-omap/msg91161.html
> 
> [PATCH v4,3/3] http://www.spinics.net/lists/linux-omap/msg91167.html

Could you please rebase on for_3.11/dts and repost the whole stuff. It
looks like Tony already pulled the GPMC node, and the two other ones
cannot apply anymore.

Thanks,
Benoit


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
