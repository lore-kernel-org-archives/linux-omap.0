From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH 10/20] Move rfbi init to rfbi probe
Date: Tue, 31 Aug 2010 18:27:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA762@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com> <4C77C397.5010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46565 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756859Ab0HaM6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 08:58:04 -0400
In-Reply-To: <4C77C397.5010502@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Friday, August 27, 2010 7:25 PM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com; Hilman, Kevin
> Subject: Re: [PATCH 10/20] Move rfbi init to rfbi probe
> 
> On 8/23/2010 5:57 PM, Guruswamy, Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >
[...]
> > @@ -199,12 +199,6 @@ static int omap_dss_probe(struct 
> platform_device *pdev)
> >
> >   	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> >
> > -	r = rfbi_init();
> > -	if (r) {
> > -		DSSERR("Failed to initialize rfbi\n");
> > -		goto err_rfbi;
> > -	}
> > -
> >   	r = dpi_init(pdev);
> >   	if (r) {
> >   		DSSERR("Failed to initialize dpi\n");
> > @@ -278,8 +272,6 @@ err_venc:
> >   err_dispc:
> >   	dpi_exit();
> >   err_dpi:
> > -	rfbi_exit();
> > -err_rfbi:
> >   	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> >
> >   	return r;
> > @@ -296,7 +288,6 @@ static int omap_dss_remove(struct 
> platform_device *pdev)
> >   	venc_exit();
> >   	dispc_exit();
> >   	dpi_exit();
> > -	rfbi_exit();
> >   	if (cpu_is_omap34xx()) {
> >   		dsi_exit();
> >   		sdi_exit();
> > @@ -357,11 +348,21 @@ static int omap_dsi1hw_remove(struct 
> platform_device *pdev)
> >   /* RFBI HW IP initialisation */
> >   static int omap_rfbihw_probe(struct platform_device *pdev)
> >   {
> > -	return 0;
> > +	int r;
> > +	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> > +	r = rfbi_init();
> > +	if (r) {
> > +		DSSERR("Failed to initialize rfbi\n");
> > +		goto err_rfbi;
> > +	}
> > +err_rfbi:
> > +	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> > +	return r;
> 
> There is probably something wrong in this sequence? The same thing is 
> done whatever the return state (except the error log).
> You should probably return 0 and not disable the clocks if 
> the rfbi_init 
> is successful.
> 
[Senthil] I don't see any wrong in functionality, but creates confusion.
Let me init r =0.  dss_clk_disable has to be called at the end of probe
irrespective of error. I can remove err_rfbi: since no specific error handling is getting done now.

> Benoit
> 