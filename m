From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 207/493] i2c: remove use of __devinit
Date: Tue, 20 Nov 2012 14:37:43 +0100
Message-ID: <20121120143743.3f54a3cb@endymion.delvare>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
	<20121120092046.24496415@endymion.delvare>
	<20121120132342.GP3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121120132342.GP3332-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Nov 2012 13:23:42 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2012 at 09:20:46AM +0100, Jean Delvare wrote:
> > Hi Bill,
> > 
> > On Mon, 19 Nov 2012 13:22:36 -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > needed.
> > 
> > Can you please point me/us to the discussion explaining the rationale
> > behind this move, and the explanation of what will be done exactly?
> > While I can easily understand that we want to drop CONFIG_HOTPLUG and
> > always enable hot-plug support, I don't see where we are going with
> > removing __devinit annotations and the like.
> 
> It's actually very simple to understand.
> 
> 1. CONFIG_HOTPLUG is going away; it's already defined to always be 'Y'.
> 2. This means that the the devinit sections will not be discarded anymore.
> 3. As a result, there's no point the devinit sections existing anymore.
> 4. As there's no devinit sections, the __devinit marker is entirely
>    redundant and useless.

Ah, yes, very simple indeed. Not sure how I managed to not understand
it earlier today. Thanks for explaining.

> The reason this is being done is because the benefit to cost ratio of this
> is far too high; it's well proven that people constantly get these markings
> wrong, and with most kernels having had hotplug enabled anyway, it's not
> providing much in the way of space saving benefit over the number of section
> conflicts it causes.  So, it's been decided a few years ago that this is

Yes, I completely agree.

> going to happen, with that justification, and it's been accepted by 300
> odd kernel developers in at least one kernel summit when it was talked

Probably that was one I didn't attend to, as I can't remember this
discussion.

> about... and it's been mentioned on mailing lists several times.

Maybe LKML, which I don't read. So I wasn't aware of the plan before
seeing Bill's patches.

-- 
Jean Delvare
