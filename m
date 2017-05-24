From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature (fwd)
Date: Wed, 24 May 2017 20:41:10 +0100
Message-ID: <20170524204110.1f2400d3@kernel.org>
References: <alpine.DEB.2.20.1705240938520.2983@hadrien>
        <20170524154612.GZ10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170524154612.GZ10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 24 May 2017 08:46:12 -0700
Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi,
> 
> * Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org> [170524 00:43]:
> > CPCAP_BIT_ADTRIG_DIS is duplicated on lines 77-82.
> > 02e16000 Tony Lindgren 2017-05-22  77  #define CPCAP_REG_ADCC2_DEFAULTS	(CPCAP_BIT_AD4_SELECT | \
> > 02e16000 Tony Lindgren 2017-05-22 @78  					 CPCAP_BIT_ADTRIG_DIS | \
> > 02e16000 Tony Lindgren 2017-05-22  79  					 CPCAP_BIT_ADTRIG_DIS | \  
> 
> Oops, thanks for letting me know.
> 
> Jonathan, do you want an incremental patch or v3 of the whole set resent?
> 
> Regards,
> 
> Tony

Fixed up and repushed out.  Thanks

Jonathan
