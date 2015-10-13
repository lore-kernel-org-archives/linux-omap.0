From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
Date: Tue, 13 Oct 2015 08:43:07 +0200
Message-ID: <CAAfyv37SFd+fq_=x9oO0KBzgcFDpyJZXCZ_QEQkFPzwTf+r9Cg@mail.gmail.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
	<1443212447-5841-3-git-send-email-marek@goldelico.com>
	<20150926172936.GD22315@earth>
	<CAAfyv36nZ3c-yw7QQHwBWk3GwY31rV3Uq2n0dz5hppn5JFhEcA@mail.gmail.com>
	<20151012213827.GC23801@atomide.com>
	<20151012222009.GH23801@atomide.com>
	<20151012235343.GA7755@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012235343.GA7755@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Neil Brown <neilb@suse.de>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 13, 2015 at 1:53 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Oct 12, 2015 at 03:20:10PM -0700, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [151012 14:43]:
>> > * Belisko Marek <marek.belisko@gmail.com> [150926 13:02]:
>> > > Tony sorry I forgot to add you to the recipients for this patchset.
>> > > Can you please queue this patch. Many thanks.
>> >
>> > OK applying into omap-for-v4.4/dt thanks.
>>
>> Actually dropping this one, it makes build fail as we don't
>> have twl4030_madc yet.
>>
>> Maybe please send a separate set of dts patches for me.
>
> mh that's strange, twl4030-madc is there since a long time. But
> checking the patch, it seems Marek got the phandle wrong:
OK, thanks for letting me know. I'll send update soon. Thanks.
>
> $ grep -B1 "ti,twl4030-madc" arch/arm/boot/dts/twl4030.dtsi
>         twl_madc: madc {
>                 compatible = "ti,twl4030-madc";
>
> Once that is fixed, the patch should have no dependencies.
>
> -- Sebastian

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
