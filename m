From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 13:27:25 +0200
Message-ID: <4BF51C9D.8050406@nt.tu-darmstadt.de>
References: <1274115885.4418.59.camel@mulgrave.site> <1274191188.10304.5.camel@mulgrave.site> <20100519065934.GH12879@nokia.com> <201005192242.55706.rjw@sisk.pl> <20100520044926.GB6773@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:30715 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab0ETL2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 07:28:39 -0400
In-Reply-To: <20100520044926.GB6773@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "ext Rafael J. Wysocki" <rjw@sisk.pl>, ext James Bottomley <James.Bottomley@suse.de>, "me@felipebalbi.com" <me@felipebalbi.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Felipe Balbi wrote:
> Hi,
>
> On Wed, May 19, 2010 at 10:42:55PM +0200, ext Rafael J. Wysocki wrote:
>>Please note that this approach is not too practical for vendors who ship
>>systems like cell phones to the general public.
>
> yeah, tell me about it :-p
>
> during development on MeeGo devices we try to tackle down as much as
> possible the use_time offenders and start by filing bugs to those apps,
> instead of fixing their issues in kernel space.

And you will continue doing that once the Meego app store has 100k apps?
