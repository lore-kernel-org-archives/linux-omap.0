From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Subject: Re: [PATCH] regulator: tps65910: wire up sleep control configuration
Date: Wed, 14 Jun 2017 20:54:58 +0200
Message-ID: <20170614185458.3vhuhjdpf5pabsis@qmqm.qmqm.pl>
References: <efc798c2a1140c545cc210a29ed2791495956510.1497442770.git.mirq-linux@rere.qmqm.pl>
 <20170614144208.nmiq2zijkyoajqgn@sirena.org.uk>
 <20170614151329.7kb266gnksryr45y@qmqm.qmqm.pl>
 <20170614171518.xlhpidf4fm65g7tf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170614171518.xlhpidf4fm65g7tf-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 14, 2017 at 06:15:18PM +0100, Mark Brown wrote:
> On Wed, Jun 14, 2017 at 05:13:29PM +0200, Micha³ Miros³aw wrote:
> > On Wed, Jun 14, 2017 at 03:42:08PM +0100, Mark Brown wrote:
> > > On Wed, Jun 14, 2017 at 02:25:13PM +0200, Micha³ Miros³aw wrote:
> > > > References: 201cf052810d20814a77ca0e0045a2c1a3508a1f
> 
> > > I have no idea what you mean by this, sorry.
> 
> > This is a commit id which introduced the feature:
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
> 
> I also still don't entirely know what you're trying to tell me with
> this...  as far as I can tell it's just noise?

As the patch only modifies device-tree binding, I included reference
to a patch that implements the feature. I guess this is not of much
use to you if you don't have access to the git tree while reviewing.

Since this is rather easy to find in git history, I will just remove the
References line.

Best Regards,
Micha³ Miros³aw
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
