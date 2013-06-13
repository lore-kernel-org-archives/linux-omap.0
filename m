From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 5
Date: Thu, 13 Jun 2013 11:07:19 +0200
Message-ID: <20130613090719.GB7998@zurbaran>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371056302-12714-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Wed, Jun 12, 2013 at 06:58:01PM +0200, Sebastian Andrzej Siewior wrote:
> Hi Samuel,
> 
> I did the cosmetic changes of the subject line and removed the changes
> from within the sob lines in each patch. I dropped the "#define XPP
> STEPCONFIG_XPP" thingy and patch #1 which removed regmap from mfd. Not
> that I agree with it, I just do not want to miss the merge window due to
> this.
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://breakpoint.cc/bigeasy/linux tags/am335x_tsc-adc
Pulled and pushed back to mfd-next, thanks.
I fixed a couple of unused variable warnings on top of it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
