From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Define use internal clock field
	inMMCconfiguration
Date: Fri, 8 Jun 2007 03:28:57 -0700
Message-ID: <20070608102856.GL28556@atomide.com>
References: <01ff01c7a0c3$bccee110$e1ac580a@swcenter.sec.samsung.co.kr>
	<5d5443650705280124i522a005fyd8287c9c5eb2e9ac@mail.gmail.com>
	<020401c7a103$b44baa60$e1ac580a@swcenter.sec.samsung.co.kr>
	<20070605102622.GE859@atomide.com>
	<009101c7a898$8de1a860$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <009101c7a898$8de1a860$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kmpark@infradead.org> [070606 17:13]:
> Hi, Tony
> 
> > > diff --git a/arch/arm/mach-omap2/board-apollon.c
> > > b/arch/arm/mach-omap2/board-apollon.c
> > > index 1276f1f..16428f6 100644
> > > --- a/arch/arm/mach-omap2/board-apollon.c
> > > +++ b/arch/arm/mach-omap2/board-apollon.c
> > > @@ -251,6 +251,8 @@ static struct omap_mmc_config apollon_mmc_config
> > __initdata
> > > = {
> > 
> > Your patch was wrapped again...
> 
> Umm, I set the Outlook configuration as suggested one.
> Next time, I try to use another mail client to send the patch.

Great, it's nice to apply patches directly without any editing with
git-am :)

Tony
