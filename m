From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 11:57:40 +0300
Message-ID: <20100520085739.GB14584@gandalf>
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
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100520071528.494c38e4@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: felipe.balbi@nokia.com, ext James Bottomley <James.Bottomley@suse.de>, "me@felipebalbi.com" <me@felipebalbi.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 20, 2010 at 07:15:28AM +0200, Florian Mickler wrote:
> But with that, you still shift the burden of exchanging that app with
> an feature-equivalent non-broken version to the user. 
> which is not user friendly and not necessary if you have a "smart"
> enough kernel.

and _without that_, you shift the burden of having a working power
management completely into the kernel. Forcing the kernel to deal with
completely broken apps. What will happen is that apps developers won't
boder thinking about power consumption since the kernel is "smart"
enough to "fix" their mess.

To me that's much bigger burden to the kernel than the other option is
to apps.

-- 
balbi
