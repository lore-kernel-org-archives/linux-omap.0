From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 07:49:26 +0300
Message-ID: <20100520044926.GB6773@nokia.com>
References: <1274115885.4418.59.camel@mulgrave.site>
 <1274191188.10304.5.camel@mulgrave.site>
 <20100519065934.GH12879@nokia.com>
 <201005192242.55706.rjw@sisk.pl>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201005192242.55706.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext James Bottomley <James.Bottomley@suse.de>, "me@felipebalbi.com" <me@felipebalbi.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, May 19, 2010 at 10:42:55PM +0200, ext Rafael J. Wysocki wrote:
>Please note that this approach is not too practical for vendors who ship
>systems like cell phones to the general public.

yeah, tell me about it :-p

during development on MeeGo devices we try to tackle down as much as 
possible the use_time offenders and start by filing bugs to those apps, 
instead of fixing their issues in kernel space.

if suspend_blockers could at least be transparent to applications, then 
it wouldn't be the best scenario but at least applications wouldn't have 
to be specially written to support that. And like I said, if anyone can 
hold a suspend_blocker forever the idea of "improving use_time" is easy 
to break, but then someone replied "anyone holding a suspend_blocker 
will show up in UI", and again I say you don't need suspend_blockers to 
have a fancy UI showing which processes are waking up the processor. 
Powertop already gathers that information, you just need to make a fancy 
UI around it.

-- 
balbi

DefectiveByDesign.org
