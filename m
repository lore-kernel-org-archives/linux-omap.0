From: tony@atomide.com
Subject: Re: DM timer APIs to be exported?
Date: Mon, 19 Mar 2007 15:14:51 -0400
Message-ID: <20070319191449.GC6831@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4776431E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4776431E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070314 22:02]:
> Hi,
> 
>  
> 
> The DM timer APIs are not exported. What if a kernel driver/module needs
> to use same?

I guess so far nobody has needed them in a driver.
 
> Do we have to export these APIs? Please correct me if I am wrong.

Sure if needed. We don't want to export the system timer though.

Tony
