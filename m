From: Jeroen Hofstee <linux-arm@myspectrum.nl>
Subject: Re: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
Date: Wed, 15 Apr 2015 00:10:23 +0200
Message-ID: <552D904F.70003@myspectrum.nl>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl> <552840A9.8070406@myspectrum.nl>
 <20150411075220.GK12732@n2100.arm.linux.org.uk>
 <5528E88C.4070107@myspectrum.nl> <20150413143941.GY18048@atomide.com>
 <20150413162808.GZ18048@atomide.com>
 <20150413213556.GT4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150413213556.GT4027@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jeroen Hofstee <jhofstee@victronenergy.com>, =?windows-1252?Q?Andreas_Bie=DFmann?= <andreas.devel@googlemail.com>, linux-omap@vger.kernel.org, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Russell,

On 13-04-15 23:35, Russell King - ARM Linux wrote:
> On Mon, Apr 13, 2015 at 09:28:09AM -0700, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [150413 07:46]:
>>> If what Russell and I are saying is correct, with the above two
>>> patches your system should behave properly with 430973 even if
>>> bit 6 in the aux ctrl register is set (or unset) by the bootloader.
>>>
>>> If r1p7 is behaves with bit 6 cleared and errata 430973 set, then
>>> we know r1p7 is unaffected by 430973.
>> Sorry let's take this part again:
>>
>> If r1p7 is behaves with bit 6 cleared and errata 430973 _unset_,
>> then we know r1p7 is unaffected by 430973.
> I've asked.  The errata applies to _all_ Cortex A8 r1pX versions.
> This is actually what the code in the kernel does today, but the
> documentation does not reflect it.  So, I've updated the
> documentation to reflect (a) the code and (b) the info I received:
>
> http://ftp.arm.linux.org.uk/cgit/linux-arm.git/commit/?id=59552cc87cb6
>

Good, that also matches with the patch I posted, [r1p4 .. r1p6]
are not necessarily not affected, they simply are not mentioned in the
errata. r1p7 is the last from the r1pX range. From r2p1 on things should
no longer need to workaround.

Regards,
Jeroen
