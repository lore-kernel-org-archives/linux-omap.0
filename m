From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3 00/11] staging tidspbridge: iommu migration
Date: Tue, 12 Oct 2010 14:20:59 +0300
Message-ID: <AANLkTim6XRgnefA0vmRNeW=TONhxz68WYAjuA96LqWOj@mail.gmail.com>
References: <1286310944-25035-1-git-send-email-x0095840@ti.com>
	<AANLkTimoTmhAw11jJihiuyByzKZ9KTFHvx6iw8oeLCGg@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BB1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2BB1@dlee06.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 11, 2010 at 6:03 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> On Tue, Oct 5, 2010 at 11:35 PM, Fernando Guzman Lugo
>> <x0095840@ti.com> wrote:
>> > This set of patches remove the dspbridge custom mmu
>> implementation and
>> > use iommu module instead.
>>
>> I have tried this, it works for simple tests, but not real use-cases.
>> I applied all your iommu patches. How did you test this?
>
> Have you applied:
>
> - "scatterlist: define SG chain for arm architecture"
> - "iovmm: replace __iounmap with omap_iounmap"
> - "iovmm: add superpages support to fixed da address"
> - "iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF"
> - "iovmm: no gap checking for fixed address"

Yes.

> Also make sure your baseline have this patch:
>
> - "omap:iommu-load cam register before flushing the entry"

Huh? That's not even in v2.6.36-rc7, in which baseline is this
supposed to be in? Anyway, I'll try adding that.

> What kind of error are you getting?

Node allocation failing IIRC.

> I don't have a complete framework to test MM testcases at this moment

See:
http://felipec.wordpress.com/2010/10/08/my-arm-development-notes/

I even prepared a tarball so you just need to extract it on your
device. It's not difficult to test this with GStreamer, and I don't
see how you can be confident that they indeed work without testing
some real use-cases. Anyway, I'll try that missing patch.

Cheers.

-- 
Felipe Contreras
