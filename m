From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Tue, 27 Feb 2018 08:32:50 +0100
Message-ID: <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180227070415.GB18666@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <treding@nvidia.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Johan,

> Am 27.02.2018 um 08:04 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
>> Hi!
>> 
>>>> Let's restart this discussion and focus on the main roadblock (others
>>>> are minor details which can be sorted out later).
>>>> 
>>>> If it feels like a hack, the key issue seems to me to be the choice of
>>>> the API to present the GPS data to user space. Right?
>>> 
>>> Or even more fundamentally, does this belong in the kernel at all?
>> 
>> Yes, it does.

Thanks, Pavel for supporting our view.

> 
> But not necessarily in its current form.

Is this a "yes after some code fixes"?

Pavel mentioned an example where such an evolutionary approach was taken.

> 
>>> Now, if we'd ever have a proper GPS framework that handled everything in
>>> kernel space (i.e. no more gpsd) then we would be able to write kernel
>>> drivers that also take care of PM. But perhaps that's unlikely to ever
>>> be realised given the state of things (proprietary protocols, numerous
>>> quirky implementations, etc).
>> 
>> That is what needs to happen.
>> 
>>> The kernel is probably not the place to be working around issues like
>>> that, even if serdev at least allows for such hacks to be fairly
>>> isolated in drivers (unlike some of the earlier proposals touching core
>>> code).
>> 
>> Oh, kernel is indeed right place to provide hardware abstraction --
>> and that includes bug workarounds.
> 
> Right, at least when such hacks can be confined to a driver and not be
> spread all over the place.

It seems that you forgot that the driver we propose is not spread all over
the place. It *is* confined to a single driver thanks to the serdev api.

BR and thanks,
Nikolaus
