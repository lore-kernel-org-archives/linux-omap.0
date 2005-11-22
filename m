From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] omap24xx mcbsp support
Date: Mon, 21 Nov 2005 20:56:15 -0800 (PST)
Message-ID: <20051122045615.34106.qmail@web32913.mail.mud.yahoo.com>
References: <20051121183302.GE7680@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051121183302.GE7680@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> 
> One comment on the patch below:
> 
> > @@ -228,8 +231,10 @@ int omap_mcbsp_request(unsigned int id)
> >  	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
> >  	 * are DSP public peripherals.
> >  	 */
> > -	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> > -		omap_mcbsp_dsp_request();
> > +	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
> > +		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> > +			omap_mcbsp_dsp_request();
> > +	}
> >  
> >  	spin_lock(&mcbsp[id].lock);
> >  	if (!mcbsp[id].free) {
> > @@ -274,8 +279,10 @@ void omap_mcbsp_free(unsigned int id)
> >  	if (omap_mcbsp_check(id) < 0)
> >  		return;
> >  
> > -	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> > -		omap_mcbsp_dsp_free();
> > +	if (cpu_is_omap1510() || cpu_is_omap24xx()) {
> > +		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> > +			omap_mcbsp_dsp_free();
> > +	}
> >  
> >  	spin_lock(&mcbsp[id].lock);
> >  	if (mcbsp[id].free) {
> 
> AFAIK 730 and 24xx do not have mcbsp wired to DSP, and only 15xx
> and 16xx have it wired to DSP. Then the second chunk above should
> probably be also if (cpu_is_omap1510() || cpu_is_omap16xx()) ?

OK. I will modify that. Thanx for the review.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
