From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: is the OMAP5912 support boot by NAND flash?
Date: Tue, 29 Nov 2005 11:14:17 +0900
Message-ID: <0IQP002XD27TVU@mmp2.samsung.com>
References: <002901c5f47b$73bb32d0$0801a8c0@andy>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <002901c5f47b$73bb32d0$0801a8c0@andy>
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
> Did you mean that I can use NOR interface and configure to 
> NAND protocol?

No. NAND can't use NOR interface.
That for OneNAND which has NOR interface with NAND core

You can also refer to http://linux.omap.com/pub/xloader/source/

The old version has NAND boot on omap730 
But I'm not sure it's code is working?

Thank you

Kyungmin Park
