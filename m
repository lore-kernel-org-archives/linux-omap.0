From: Olav Kongas <ok@artecdesign.ee>
Subject: RE: omap5912 and regular DDR
Date: Tue, 20 Dec 2005 20:51:54 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0512202046200.7730@pcy.artec.ee>
References: <C51F43ABFC95844490F0529B60753BF402EC21A6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF402EC21A6@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



On Tue, 20 Dec 2005, Hunter, Jon wrote:

> > Jon, I would most appreciate if you could find out and reveal 
> > the reason, why rDDR is not officially supported on omap5912. 
> 
> 
> I doubled checked on this as it had been sometime since I had looked at
> this. However, the official statement still is that we do not support
> ddr1. The problem is that the internal i/o buffer on the 5912 will not
> meet the JEDEC spec for ddr1. It could be possible that it may work,
> however, we cannot guarantee across all devices produced that it will
> work as there will be some variation in the silicon between parts. 

Jon, thank you so much.

Olav
