From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 03/32] OMAPDSS: add omap_dss_find_output()
Date: Thu, 30 May 2013 17:40:55 +0200
Message-ID: <20130530154055.GL19468@game.jcrosoft.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-4-git-send-email-tomi.valkeinen@ti.com>
 <20130530110707.GH19468@game.jcrosoft.org>
 <51A73A9A.8010801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:51858 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750895Ab3E3PpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 11:45:07 -0400
Received: from mail439.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 0A2C5FFAED1
	for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 17:45:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51A73A9A.8010801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 14:40 Thu 30 May     , Tomi Valkeinen wrote:
> On 30/05/13 14:07, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> >> Add a support function to find a DSS output by given name. This is used
> >> in later patches to link the panels to DSS outputs.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/output.c | 13 +++++++++++++
> >>  include/video/omapdss.h          |  1 +
> >>  2 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
> >> index 5214df6..3274628 100644
> >> --- a/drivers/video/omap2/dss/output.c
> >> +++ b/drivers/video/omap2/dss/output.c
> >> @@ -115,6 +115,19 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
> >>  }
> >>  EXPORT_SYMBOL(omap_dss_get_output);
> > GPL please
> 
> The omapdss driver uses EXPORT_SYMBOL. I don't want to start mixing both
> EXPORT_SYMBOLs and EXPORT_SYMBOL_GPLs.

I do not like EXPORT_SYMBOL at all
I stringly prefer to switch all of them to _GPL

but will not refuse the patch for this in this case
> 
> >> +struct omap_dss_output *omap_dss_find_output(const char *name)
> >> +{
> >> +	struct omap_dss_output *out;
> >> +
> >> +	list_for_each_entry(out, &output_list, list) {
> >> +		if (strcmp(out->name, name) == 0)
> >> +			return out;
> >> +	}
> >> +
> >> +	return NULL;
> >> +}
> > I this in so many drivers could we have a macro to generate such function?
> 
> What would that help? Wouldn't it just increase the code size of the kernel?

increase no as it's not an inline function but a macro to generate the
function
after help yes but people may not like so as you wish

Best Regards,
J.
> 
>  Tomi
> 
> 


