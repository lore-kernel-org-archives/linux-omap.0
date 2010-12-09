From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/11] OMAP2+: clockdomains: split the clkdm hwsup
 enable/disable function
Date: Wed, 8 Dec 2010 17:00:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061838.30541.36426.stgit@twilight.localdomain> <871v5rg8px.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0LIAAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 19:00:22 -0500
In-Reply-To: <871v5rg8px.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Wed, 8 Dec 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
>
> > - * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
> > +/**
> > + * _enable_hwsup - set the hwsup idle transition bit
> > + * @clkdm: struct clockdomain *
> > + *
> > + * XXX fix doco
> 
> hmm, 'doco' must be a new lingo I haven't learned yet.

Thanks, will fix these.


- Paul
