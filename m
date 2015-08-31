From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
Date: Mon, 31 Aug 2015 08:46:46 -0500
Message-ID: <20150831134645.GA11095@deathstar>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
 <20150724163946.GN11162@sirena.org.uk>
 <55E31701.7050807@bitmer.com>
 <20150830164444.GA22471@deathstar>
 <20150831085355.GF12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150831085355.GF12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 31, 2015 at 09:53:55AM +0100, Mark Brown wrote:
> On Sun, Aug 30, 2015 at 11:44:45AM -0500, Michael Welling wrote:
> 
> > The patch is currently sitting in linux-next.
> 
> > Not sure why it wasn't merged with 4.2.0-rc8.
> 
> You didn't indicate that it was a bug fix for Linus rather than a fix
> for recent development :(

Sorry, I did not know that it was my responsibility.

How do I indicate this for future reference?

The patch that Sebastian sent said the following:
"
Michael also tested the patch, but have not explicitly written an
Tested-By, so you may want to wait for feedback from him. The patch
should be sent for 4.2-rc, which introduced the regression.
"

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
