From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 7/7] omap3: make coresight register save across OFF modes
 a sysfs option
Date: Sat, 04 Sep 2010 10:57:06 +0200
Message-ID: <4C8209E2.3080803@ti.com>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com> <1280077520-7538-8-git-send-email-virtuoso@slind.org> <20100806123711.GI28519@shisha.kicks-ass.net> <20100806124726.GN23778@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100806124726.GN23778@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 8/6/2010 2:47 PM, Tony Lindgren wrote:
> * Alexander Shishkin<virtuoso@slind.org>  [100806 15:30]:
>> On Sun, Jul 25, 2010 at 08:05:20 +0300, Alexander Shishkin wrote:
>>> This adds a sysfs file at /sys/power/coresight_save which is used to
>>> control if the ETM and debug components' states should be saved and
>>> restored across OFF modes.
>>
>> The non-omap patches are merged to Russell's tree, so these three are
>> the only remaining.
>>
>> This one won't apply to linux-omap master any more because of the pm44xx
>> in the makefile, but should be ok otherwise. It would still apply to
>> linus' tree.
>>
>> So, should I rediff it, resend it or just drop it, because it's not needed?
>
> Patches look OK to me.

These patches are still using static virtual to physical mapping in 
io.h,  shouldn't we take the opportunity of this series to fix that and 
use ioremap instead?

Or do you prefer to do that in a second step?

Regards,
Benoit
