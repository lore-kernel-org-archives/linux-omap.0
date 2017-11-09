From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
Date: Thu, 9 Nov 2017 18:16:29 +0100
Message-ID: <450E9318-EB71-4635-A137-82DF78206D24@goldelico.com>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
 <20171108222755.GW28152@atomide.com>
 <20171108223604.GG28231@n2100.armlinux.org.uk>
 <20171108223810.GH28231@n2100.armlinux.org.uk>
 <E542DC13-D6C4-4C84-8521-8CE468BD0AFE@goldelico.com>
 <20171109165840.GI28231@n2100.armlinux.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171109165840.GI28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: letux-kernel@openphoenux.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russel,

> Am 09.11.2017 um 17:58 schrieb Russell King - ARM Linux <linux@armlinux.org.uk>:
> 
> On Thu, Nov 09, 2017 at 06:44:49AM +0100, H. Nikolaus Schaller wrote:
>> Hi Russel,
> 
> Nikolus,
> 
>>> Am 08.11.2017 um 23:38 schrieb Russell King - ARM Linux <linux@armlinux.org.uk>:
>>> 
>>> On Wed, Nov 08, 2017 at 10:36:04PM +0000, Russell King - ARM Linux wrote:
>>>> We don't need a compiler warning there, we probably need better help
>>>> text against DEBUG_LL and against EARLY_PRINTK.
>>> 
>>> Actually, this is already clearly stated against DEBUG_LL:
>>> 
>>>         Note that selecting this option will limit the kernel to a single
>>>         UART definition, as specified below. Attempting to boot the kernel
>>>         image on a different platform *will not work*, so this option should
>>>         not be enabled for kernels that are intended to be portable.
>>> 
>>> and since EARLY_PRINTK depends on DEBUG_LL... I guess people don't
>>> read help texts anymore.
>> 
>> Yes, we read, but we face a situation where it doesn't help that it is a
>> well known problem *for you* or anyone else and that it is described in
>> the help.
> 
> Personally, I'd like early_printk not to be re-using this, but others
> disagree.  It's all about knowledge and compromise.

Sure, we have to make a lot of compromises...

> 
> What we don't want is more warnings in the kernel - it's already
> hard enough for people to spot the "bad" warnings that they need to
> fix to have a working system (such as wrong printf specifiers) that
> (a) they're not going to spot this #warning and (b) it's just going
> to be more noise for those who do try to spot the warnings.

> 
>> Do you expect anybody to remember after 3 years of *not* changing DEBUG_LL
>> what was written in a help message? Or to understand that DEBUG_LL has
>> anything to do with the mysteriously appearing boot problem? Which can't
>> easily be debugged since there are no messages despite playing with
>> EARLY_PRINTK/EARLYCON?
> 
> Do you expect people to read the build log of their kernel and spot
> the additional warning?

I am doing it and I rarely see warnings by the compiler. Maybe sometimes
during the -rc phase but not in stable.

>  You might be on the ball enough to do that,
> but not everyone does, or is.  Not everyone logs the output of the
> kernel build so they can review it later.  I suspect that many just
> set the build going in a terminal, walk away and come back sometime
> later when they think it's done.

In this case they would have a good trigger and reason to look into the
build log: the kernel they just built isn't booting and doesn't tell
anything. Then I guess for many of us the next logical step would be to
look trough the build log (but not through a defconfig that wasn't touched
for ages).

Well, I have to admit that if someone doesn't try a clean build, it
will not see it again if the initial log wasn't captured somewhere...

So it should more be an #error than a #warning. Then people must notice.
But I don't know if there are situations where this would be too strict.

And in this special case someone may even have the idea to enable DEBUG_LL
to get better error reporting - but find it is already enabled. Not knowing
that this is the reason of the problem. This is what IMHO makes this case
very special.

Or the other option would be to automatically disable DEBUG_LL if it
conflicts. Then, there is no need for a warning that could be ignored.

>  (This view is based upon the number
> of warnings that I've seen crop up that are for things that are real
> bugs that others have introduced - had the warnings been spotted, it
> would've triggered a "oh, that's not right" moment.)

BR and thanks,
Nikolaus
