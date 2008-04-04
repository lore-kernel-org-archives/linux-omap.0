From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] dmtimer posting
Date: Thu, 3 Apr 2008 23:50:09 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903F14322@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com> <20080331104904.GK26502@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903E22347@dlee13.ent.ti.com> <20080402072340.GH31913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48383 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbYDDEvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 00:51:04 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080402072340.GH31913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

> >
> > In that variant I just added a load_start() function in addition to
the
> > load function and converted all the in tree callers to use this as
they
> > all called load() then start() in order anyway.  This left the API
> > behavior the same but optimized all current users.
> 
> Can you send a patch against l-o tree for the load_start()? That might
> be optimized enough :)

Sure, I'll see about it hopefully tomorrow.

Regards,
Richard W.
