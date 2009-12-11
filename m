From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v7 3/5] OMAP: McBSP: Introduce caching in register write operations
Date: Fri, 11 Dec 2009 14:51:27 +0100
Message-ID: <200912111451.29185.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl> <200912092131.21517.jkrzyszt@tis.icnet.pl> <20091211151149.c20acce5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:58344 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757571AbZLKNv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:51:26 -0500
In-Reply-To: <20091211151149.c20acce5.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

=46riday 11 December 2009 14:11:49 Jarkko Nikula napisa=C5=82(a):
> On Wed, 9 Dec 2009 21:31:20 +0100
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > @@ -391,6 +405,10 @@ int omap_mcbsp_request(unsigned int id)
> >  	}
> >  	mcbsp =3D id_to_mcbsp_ptr(id);
> >
> > +	mcbsp->reg_cache =3D kzalloc(omap_mcbsp_cache_size, GFP_KERNEL);
> > +	if (!mcbsp->reg_cache)
> > +		return -ENOMEM;
> > +
> >  	spin_lock(&mcbsp->lock);
> >  	if (!mcbsp->free) {
> >  		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
>
> Great work. Could have my ack to patches 1-4 by moving the cache
> allocation after the mcbsp->free test lines. Memory leak and other
> badness would happen otherwise in case of multiple call to
> omap_mcbsp_request.

Yes, it's a bug, sorry.

> Just send an update to this mail if there is no comments to another
> patches.

OK.

Thanks,
Janusz

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
