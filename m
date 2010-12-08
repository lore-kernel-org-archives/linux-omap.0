From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning in mfd/twl-core.c
Date: Wed, 8 Dec 2010 09:45:11 +0800
Message-ID: <AANLkTim03xqbrkhyN1oR+ksoEuC-utD58h_5A3psRiUX@mail.gmail.com>
References: <alpine.DEB.2.00.1012061734590.13430@utopia.booyaka.com>
 <AANLkTimXPFROMQ_fF4Od-jw3aDY0WZQgc=x14=VcFM3d@mail.gmail.com>
 <alpine.DEB.2.00.1012061839170.13430@utopia.booyaka.com> <20101207094841.GA4772@sortiz-mobl>
 <alpine.DEB.2.00.1012070911380.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1012070911380.13430@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 12:12 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Samuel,
>
> On Tue, 7 Dec 2010, Samuel Ortiz wrote:
>
>> On Mon, Dec 06, 2010 at 06:40:38PM -0700, Paul Walmsley wrote:
>> >
>> > That's fine with me. =A0Samuel et al, Bryan's already done a patch
>> > for this stuff:
>> >
>> > https://patchwork.kernel.org/patch/367011/
>> >
>> > so we should use that instead, if you're happy with it. =A0Samuel,=
 maybe we
>> > could get an ack from you on it?
>> The twl driver is not OMAP specific, so this should be a separate pa=
tch thatI
>> will merge to my mfd tree.
>> If you really insist in pushing this through Tony's tree, then pleas=
e add my
>> Acked-by for the mfd part.
>
> I don't insist at all :-)
>
> Bryan, maybe split your patch into a mach-omap2 patch and a TWL
> driver-specific patch, and send the latter for Samuel?
>
>

No problem. I'll do soon.

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
