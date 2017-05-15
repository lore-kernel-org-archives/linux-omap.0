From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 6/9] regulator: palmas: Drop unnecessary static
Date: Mon, 15 May 2017 18:41:41 +0800 (SGT)
Message-ID: <alpine.DEB.2.20.1705151838370.4315@hadrien>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr> <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr> <20170514101323.235p6jflfproucmv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170514101323.235p6jflfproucmv@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Sun, 14 May 2017, Mark Brown wrote:

> On Thu, May 04, 2017 at 10:10:51PM +0200, Julia Lawall wrote:
> > Drop static on a local variable, when the variable is initialized before
> > any use, on every possible execution path through the function.
>
> When sending a bunch of changes like this please either send the cover
> letter to everyone or send each patch separately (this seems like it
> stands alone just fine).  The first question when only one patch in a
> series is visible is always what are the interdependencies.

Not sure what is best to do.  If the cover letter goes to everyone, it
could be rejected for too many recipients.  Currently it goes to all the
mailing lists.  If the patches are sent separately, then could there be a
cover letter for each one?  If the semantic patch is complicated, then I
typically put the whole thing there, and an abbreviated one in the actual
patch.  That is not relevant here, because the semantic patch is small.
Part of the purpose of the cover letter was to allow people who were not
interested to skip over the whole thing at once.

julia
