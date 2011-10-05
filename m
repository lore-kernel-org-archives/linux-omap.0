From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
Date: Wed, 05 Oct 2011 09:11:00 -0700
Message-ID: <87aa9f771n.fsf@ti.com>
References: <871uwbhdoj.fsf@ti.com> <4E669F36.2070008@ti.com>
	<4E80FD1A.5040006@deeprootsystems.com>
	<20111004210832.GC13323@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111004210832.GC13323-RazCHl0VsYgkUSuvROHNpA@public.gmane.org> (Ben Dooks's message of
	"Tue, 4 Oct 2011 22:08:32 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:

> On Mon, Sep 26, 2011 at 03:30:50PM -0700, Kevin Hilman wrote:
>> ping
>> 
>> On 09/06/2011 03:31 PM, Kevin Hilman wrote:
>> >Hi Ben,
>> >
>> >On 08/23/2011 05:10 PM, Kevin Hilman wrote:
>> >>Ben,
>> >>
>> >>Here's one more I2C cleanup series for v3.2.
>> >>
>> >>It applies on top of my for_3.2/i2c-fixes branch just submitted.
>> >>
>> >>Please pull into your tree for linux-next.
>> >
>> >I see you pulled the other two, can you pull this one as well?
>
> I've tried, but it seems to note that everything is up to date.
>
> Is this a suitable branch to pull onto latest so I can reset
> my next tree?

Yes.

The i2c-cleanup branch[1] is based on top of the previous two (i2c-andy
and i2c-fixes) so if you reset your next-i2c branch and just pull
i2c-cleanup, you'll get all three.

Kevin

[1] git://github.com/khilman/linux-omap-pm.git for_3.2/i2c-cleanup
