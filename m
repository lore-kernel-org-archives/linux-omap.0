From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains
 functional states
Date: Fri, 4 Jan 2013 15:22:49 +0200
Message-ID: <1357305769.2221.81.camel@sokoban>
References: <20121209174545.6933.59371.stgit@dusk.lan>
	 <20121209175253.6933.87846.stgit@dusk.lan>
	 <CAORVsuXnbNLm3i=W2yb682qC1QH673nM3nPpNM_9OMds8SdzQA@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3ADNWy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 08:22:54 -0500
In-Reply-To: <CAORVsuXnbNLm3i=W2yb682qC1QH673nM3nPpNM_9OMds8SdzQA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Paul / Jean,

On Wed, 2012-12-12 at 11:33 +0100, Jean Pihet wrote:

<clip>

> > +/**
> > + * _match_pwrst: determine the closest supported power state
> > + * @pwrsts: list of allowed states, defined as a bitmask
> > + * @pwrst: initial state to be used as a starting point
> > + * @min: minimum (i.e. lowest consumption) allowed state
> > + * @max: maximum (i.e. highest consumption) allowed state
> > + *
> > + * Search down then up for a valid state from a list of allowed
> > + * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
> > + * to look for allowed power and logic states for a powerdomain.
> > + * Returns the matching allowed state.  XXX Deprecated.  The software
> > + * should not try to program unsupported powerstates.
> 
> 
> Why is this new code already deprecated? Does this require a rewrite?

Looks like it is removed by another patch in the same set and could
probably just be removed from this one also.

> > +       }
> > +
> > +       /* XXX deprecated */
> 
> 
> Same here

Same thing, maybe drop the code out completely.

-Tero


