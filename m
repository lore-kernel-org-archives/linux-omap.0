From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: MUSB: MUSB fix to work as Module for 24xx/Davinci
Date: Fri, 30 Nov 2007 02:52:02 -0800
Message-ID: <20071130105202.2C5F922248B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC08003E7FAE3@dbde01.ent.ti.com>
	<200711291022.23735.david-b@pacbell.net>
	<5DF83221BE20114E9C331F665ACBC08003F30BB4@dbde01.ent.ti.com>
	<20071130053121.C0FFA10BA22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<5DF83221BE20114E9C331F665ACBC08003F30BEF@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003F30BEF@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: vikram.pandita@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >Then the correct patch would be to set that register to zero,
> >instead of what your patch does...
>
> 24XX uses the flat model as opposed to indexed and 
> so the call musb_ep_select(mbase, 0); in following code has no affect
> for 24XX/Davinci platforms.

So you're agreeing with my comment then.
