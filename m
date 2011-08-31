From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 17:12:48 +0100
Message-ID: <4E5E5D80.6080409@arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>	<1314722311.2344.64.camel@deneb.redhat.com>	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>	<20110830174859.GA23098@kroah.com>	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>	<1314798215.2344.76.camel@deneb.redhat.com>	<20110831152137.GG8777@e102144-lin.cambridge.arm.com>
	<1314804471.2344.79.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314804471.2344.79.camel@deneb.redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Salter <msalter@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>, Chen Peter-B29397 <B29397@freescale.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 31/08/11 16:27, Mark Salter wrote:
> On Wed, 2011-08-31 at 16:21 +0100, Will Deacon wrote:
>> On Wed, Aug 31, 2011 at 02:43:33PM +0100, Mark Salter wrote:
>>> On Wed, 2011-08-31 at 09:49 +0100, Will Deacon wrote:
>>>> On Wed, Aug 31, 2011 at 01:23:47AM +0100, Chen Peter-B29397 wrote:
>>>>> One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
>>>>> also uncache, but bufferable?
>>>>
>>>> Which CPU was on this platform?
>>>
>>> Using a 3.1.0-rc4+ kernel on a Pandaboard, and running 'hdparm -t' on a
>>> usb disk drive, I see ~5.8MB/s read speed. Same kernel, but passing
>>> nosmp on the commandline, I see 20.3MB/s.
>>>
>>> Can someone explain why nosmp would make such a difference?
>>
>> Oh gawd, that's horrible. I have a feeling it's probably a separate issue
>> though, caused by:
>>
>> omap_modify_auxcoreboot0(0x200, 0xfffffdff);
>>
>> in boot_secondary for OMAP. Unfortunately I have no idea what that line is
>> doing because it ends up talking to the secure monitor.
> 
> Okay, I may poke around a bit with that to see I can get a better
> understanding.
> 
> With the patched ehci-q.c, I see no noticeable difference between smp
> and nosmp. Both get me around 23.5MB/s with my setup.

Oddly enough, this patch doesn't do anything on my Tegra setup. In both
cases, I get around 17MB/s from a crap SD card plugged in a USB reader.

This leads me to suspect that this issue is very much OMAP4 specific.
Can anyone verify this theory on other some A9 platforms?

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
