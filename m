From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/10] OMAP clockdomain/powerdomain: remove runtime
 register/unregister
Date: Tue, 19 Jan 2010 17:24:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191723250.3977@utopia.booyaka.com>
References: <20100112010258.6275.97999.stgit@localhost.localdomain> <20100112010536.6275.36524.stgit@localhost.localdomain> <87ljftd582.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51523 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0ATAYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 19:24:10 -0500
In-Reply-To: <87ljftd582.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <dbaryshkov@gmail.com>

Hi Kevin,

On Tue, 19 Jan 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > OMAP clockdomains and powerdomains are currently defined statically,
> > only registered at boot, and never unregistered, so we can remove the
> > unregister function and the locking.   A variant of this was originally
> > suggested a while ago by Dmitry Baryshkov <dbaryshkov@gmail.com>.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
> 
> Hi Paul,
> 
> This patch removes the _nolock() iterator but forgot to fixup the
> users.  I found this when building an updated PM branch on top of your
> fixes branch.

That patch is in the for_2.6.34 branch, so I'll fold your fix in there. 


thanks,

- Paul

