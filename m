From: "andy" <andy.lu@serialsys.com.hk>
Subject: RE: is the OMAP5912 support boot by NAND flash?
Date: Tue, 29 Nov 2005 10:31:23 +0800
Message-ID: <001501c5f48d$09007c40$0801a8c0@andy>
References: <0IQP002XD27TVU@mmp2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <0IQP002XD27TVU@mmp2.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Kyungmin,

As TRM said, we can configure to Address/data multiplexed
Mode for EMIF port, so I think we can use NOR interface,
Do you think so?

Best Regards
Andy Lu

-----Original Message-----
From: Kyungmin Park [mailto:kyungmin.park@samsung.com] 
Sent: Tuesday, November 29, 2005 10:14 AM
To: 'andy'; linux-omap-open-source@linux.omap.com
Subject: RE: is the OMAP5912 support boot by NAND flash?

 

> 
> Did you mean that I can use NOR interface and configure to 
> NAND protocol?

No. NAND can't use NOR interface.
That for OneNAND which has NOR interface with NAND core

You can also refer to http://linux.omap.com/pub/xloader/source/

The old version has NAND boot on omap730 
But I'm not sure it's code is working?

Thank you

Kyungmin Park
