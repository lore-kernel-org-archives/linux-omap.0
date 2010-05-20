From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 12:05:19 +0200
Message-ID: <20100520120519.0d27d6bf@schatten.dmk.lab>
References: <1274119179.4418.68.camel@mulgrave.site>
	<20100517181252.GA14260@gandalf>
	<1274124267.4418.149.camel@mulgrave.site>
	<20100517193840.GB14047@gandalf>
	<20100517193952.GC14047@gandalf>
	<1274125775.4418.182.camel@mulgrave.site>
	<20100518064022.GA6522@nokia.com>
	<1274191188.10304.5.camel@mulgrave.site>
	<20100519065934.GH12879@nokia.com>
	<20100520071528.494c38e4@schatten.dmk.lab>
	<20100520085739.GB14584@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100520085739.GB14584@gandalf>
Sender: linux-kernel-owner@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, ext James Bottomley <James.Bottomley@suse.de>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 20 May 2010 11:57:40 +0300
Felipe Balbi <me@felipebalbi.com> wrote:

> On Thu, May 20, 2010 at 07:15:28AM +0200, Florian Mickler wrote:
> > But with that, you still shift the burden of exchanging that app with
> > an feature-equivalent non-broken version to the user. 
> > which is not user friendly and not necessary if you have a "smart"
> > enough kernel.
> 
> and _without that_, you shift the burden of having a working power
> management completely into the kernel. Forcing the kernel to deal with
> completely broken apps. What will happen is that apps developers won't
> boder thinking about power consumption since the kernel is "smart"
> enough to "fix" their mess.
> 
> To me that's much bigger burden to the kernel than the other option is
> to apps.
> 

You said that already. For me this sounds like you want to take the
users hostage in order to get nice (poweraware) apps.

Robust system design can take crap and perform well. Users will most of
the time prefer a robust system over a nicely designed system. (Just
think of the ak-47)

I think we just have to agree to disagree here? 

Cheers,
Flo

p.s.: don't take me seriously, i'm just a user
