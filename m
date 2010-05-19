From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 19 May 2010 09:59:34 +0300
Message-ID: <20100519065934.GH12879@nokia.com>
References: <1274115885.4418.59.camel@mulgrave.site>
 <20100517174647.GA11512@gandalf>
 <1274119179.4418.68.camel@mulgrave.site>
 <20100517181252.GA14260@gandalf>
 <1274124267.4418.149.camel@mulgrave.site>
 <20100517193840.GB14047@gandalf>
 <20100517193952.GC14047@gandalf>
 <1274125775.4418.182.camel@mulgrave.site>
 <20100518064022.GA6522@nokia.com>
 <1274191188.10304.5.camel@mulgrave.site>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274191188.10304.5.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: ext James Bottomley <James.Bottomley@suse.de>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 03:59:48PM +0200, ext James Bottomley wrote:
>On Tue, 2010-05-18 at 09:40 +0300, Felipe Balbi wrote:
>> On Mon, May 17, 2010 at 09:49:35PM +0200, ext James Bottomley wrote:
>> >Right, because Firmware writers are from the rugged unresponsive uplands
>> >of planet
>> >ignore-user-complaints-and-eat-them-for-breakfast-if-they-file-bugs and
>> >Software writers are from the emollient responsive groves of planet
>> >harmony.  Obviously what would work for one wouldn't work for the other.
>> >
>> >As a software writer, I fully buy into that world view.  The trouble is
>> >that when I go to dinner with hardware people, they seem to be awfully
>> >nice chaps ... almost exactly like me, in fact ...
>>
>> what does this add to suspend_blockers discussion ?
>
>Sorry I was evidently being too subtle.
>
>The point is that if, as you acknowledge, that you can't train firmware
>engineers to be responsive, there's no reason to think you can train
>software engineers in the same quality ... they're very similar people.

I wouldn't say it's up to the engineer himself, it's more related to how 
the company that person works for deal with such things.

>The corollary is that real world systems have to operate in the face of
>misbehaving hardware *and* software.

I still think the kernel shouldn't deal with broken applications and we 
shouldn't try to fix them in kernel space. We can, of course, try to 
find them and have all sorts of bells and whistles shouting 'process 
%s is preventing CPU from sleeping for %llu nanoseconds' or something 
like that.

-- 
balbi

DefectiveByDesign.org
