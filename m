From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: is the OMAP5912 support boot by NAND flash?
Date: Tue, 29 Nov 2005 11:41:36 +0900
Message-ID: <0IQP00B0S3HBTW@mmp1.samsung.com>
References: <001501c5f48d$09007c40$0801a8c0@andy>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <001501c5f48d$09007c40$0801a8c0@andy>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'andy' <andy.lu@serialsys.com.hk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> As TRM said, we can configure to Address/data multiplexed
> Mode for EMIF port, so I think we can use NOR interface,
> Do you think so?
> 

Maybe you mean NOR interface is EMIFS, yes, NAND can use EMIFS
we also tested NAND on OMAP5912 but not tested NAND booting.

Regards

Kyungmin Park
