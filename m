From: Tony Lindgren <tony@atomide.com>
Subject: Re: Are we ready for 3430?
Date: Thu, 17 May 2007 10:56:31 -0700
Message-ID: <20070517175631.GC8556@atomide.com>
References: <20070517005638.997832459@pwsan.com> <464BBCC5.4080905@gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C470810AD@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470810AD@dlee13.ent.ti.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070516 20:04]:
> Hi Nishanth,
>  
> >> What platform can I test this on? I suspect more code needs to flow in
> >> before we are ready with 3430 base rt - what about base defines etc? are
> >> we about to see more 3430 patches? Are we planning on pushing all these
> >> changes to a seperate tree and integrate to mainline as we did it with 2430?

We should do the 3430 patches roughly in following steps:

- Add the necessary defines (patially include in Paul's patches)
- Changes needed for Cortex support
- Minimal changes needed to boot 3430
- Board code for 3430
- Then we can start adding the drivers one at a time :)

Regards,

Tony
