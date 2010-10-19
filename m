From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3 00/11] staging tidspbridge: iommu migration
Date: Tue, 19 Oct 2010 10:41:57 +0300
Message-ID: <AANLkTimfHtgXvJ05wOwq6oGuHDA76rpf5SANf718f8re@mail.gmail.com>
References: <1286310944-25035-1-git-send-email-x0095840@ti.com>
	<AANLkTimoTmhAw11jJihiuyByzKZ9KTFHvx6iw8oeLCGg@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BB1@dlee06.ent.ti.com>
	<AANLkTim6XRgnefA0vmRNeW=TONhxz68WYAjuA96LqWOj@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B3002@dlee06.ent.ti.com>
	<AANLkTik3hhWy+tRxThtrbwNXTssV7nf9+_LGn5Ct3iet@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F48817EF@dlee06.ent.ti.com>
	<AANLkTi=juk+824k1R8mJrDostKhRz+nRNqj9E-rNYWrv@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F4881816@dlee06.ent.ti.com>
	<AANLkTikfn9w-FMKXOVXibwHVy4vt72GdveDLVv0z3GmT@mail.gmail.com>
	<20101018230655.GJ13341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101018230655.GJ13341@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "gregkh@suse.de" <gregkh@suse.de>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 2:06 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [101015 13:09]:
>> On Fri, Oct 15, 2010 at 7:53 PM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>> >> If you want I can provide my working branch on top of .36-rc8
>> >> with next-staging merged. If I revert your patches, it works fine.
>> >
>> > That could be interested. Can you send me the link?
>>
>> There you go:
>> git://gitorious.org/~felipec/linux-omap/felipec.git (fc-dsp-work)
>>
>> HEAD works, HEAD^ doesn't.
>
> Great, can you please also let us know what if anything should
> be still queued for the merge window that's about to open?
>
> I've lost track of the dspbridge mutations by now..

We would need these:
http://article.gmane.org/gmane.linux.kernel/1044209
http://article.gmane.org/gmane.linux.ports.arm.omap/45076 (just sent)

The first one is in staging-next, you have ack'ed it, but Paul nak'ed
it. We would need it on mainline if dsp has any chances of working
there.

-- 
Felipe Contreras
