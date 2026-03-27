Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71D4035AD
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635965; cv=none; b=CraCSNCaU7ZFXs8YGjpLkh5jiw2DIa8+M0mya9TGd7gw32jwh99hYYy2Nin/ERfJtXb/w3TQmlPmO8l4uN0TWG5LBI9N4HrM6hVlvTF7ySWubNLeIkGA56p3lQe/aIAnE2N8TvWlonGAzASuAKq8S1hTrFd7d3yjV0kmMaZaytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635965; c=relaxed/simple;
	bh=HDE773oD9WhrhUQdek8MlyVxt7CVMOrinmsr0pm8nF8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZG56H53l/TYlcMKhvylp2k7J9DgF5nd7cbXzTy2uvIcXb+9xaHaX096sbg4IQwq/87ixb1EIrckpCcssHvguNiq6zUc20juZjvt5ZTMpc1QnespVwMllrqVOhiQBGCOGYJfva3A/M2ro7sM3/b9jl1Yma8IRKL+58jYs4xqUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyFxZmNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyFxZmNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2A4C2BC9E
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774635965;
	bh=HDE773oD9WhrhUQdek8MlyVxt7CVMOrinmsr0pm8nF8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=TyFxZmNPWrxOFwIoAKqmtlIJQYkfVf1WTWGlalRc0Id0h7hSeIQEDH69EWrq5WEIg
	 OVgOeSKhF86CwcTSLIOnb3puhPUmw8TdqWLLBaZDDuUiXsaf7+ynNhfTNvHFFNLz8Q
	 MTU/KhdDD6GH6sfgxnVFXgC6G94s0K6GJfhitBo0d27C30eLl0hPh/rYdVLypED47B
	 WZRUyJ/NUdiSDQq1812Jwlh1khzAWusvKG0TqI0gWkoQFVbyro9L/ncHTvnK495YSs
	 s5+1xusHLHT+wxKn8E/scV+vNATkw26XgeeNS3pQmh6MgMQNOTUHixOTsEtuiArU/V
	 l+VVKJD9WkUcQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38bd3bc3061so20049101fa.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 11:26:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2S6ffbtBjRs5AeWynHbEYiaK0wWko0sB271NIyv7VycrS+G3uDk76lW5bf3XO4XI7MDU0SSxXDsWV@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4DV1FqtDKXdHJ/gj169hfV6zN4MNkMjDsH6s7GAW8Z3z1O6B
	3eKZW5Y6fw4vJYrUTOzelrC/sGs0wAi8tmy/Su4M96JtiU9A0/bEvFRWcWwVgSta/JKObGKVC/5
	EussX5auhK9OeQjzRgbuCX9eMpFdws8lhPCb+xYjzyA==
X-Received: by 2002:a2e:a9a3:0:b0:38a:a7b4:15e8 with SMTP id
 38308e7fff4ca-38c73130537mr13693991fa.12.1774635963592; Fri, 27 Mar 2026
 11:26:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Mar 2026 11:26:02 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Mar 2026 11:26:02 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <acbI0NnMvmSiobLz@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi> <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi> <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
 <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com> <acbI0NnMvmSiobLz@google.com>
Date: Fri, 27 Mar 2026 11:26:02 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc6JwG2uMr-T0owu_reDgO5WwmzYknEKRdfQRwzuV=XHg@mail.gmail.com>
X-Gm-Features: AQROBzAMGqEEBz3VL5zOD-Izkvy7HlXo3Ok39-WVKvtwlTb9hMKkcv50nbr2CA0
Message-ID: <CAMRc=Mc6JwG2uMr-T0owu_reDgO5WwmzYknEKRdfQRwzuV=XHg@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Hans de Goede <hansg@kernel.org>, 
	Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 19:16:41 +0100, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> On Fri, Mar 27, 2026 at 10:27:07AM -0700, Bartosz Golaszewski wrote:
>> On Fri, 27 Mar 2026 18:23:29 +0100, Bartosz Golaszewski <brgl@kernel.org=
> said:
>> > On Fri, Mar 27, 2026 at 5:59=E2=80=AFPM Aaro Koskinen <aaro.koskinen@i=
ki.fi> wrote:
>> >>
>> >> Hi,
>> >>
>> >> On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
>> >> > Hmm, I'm wondering if there's a race with consumers already request=
ing
>> >> > the GPIOs after the controller device is registered but before the
>> >> > software node is added. I'll send a version with software nodes bei=
ng
>> >> > registered first, then passes as firmware nodes to the platform dev=
ice
>> >> > API before the device is registered.
>> >>
>> >> It crashes early, I was able to get an UART log from OSK (another
>> >> 16xx board):
>> >>
>> >> [    1.001525] Register r12 information: 2-page vmalloc region starti=
ng at 0xc2808000 allocated at kernel_clone+0xa4/0x20c
>> >> [    1.013092] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
>> >> [    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
>> >> [    1.024230] 9ec0:                                     c072d000 c05=
29474 c06b3aa0 c050a3cc
>> >> [    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c07=
2d000 00000000 c0503160
>> >> [    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 fff=
fffff 00010000 946f70b5
>> >> [    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c07=
2d000 c04da8f8 c0060a18
>> >> [    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c08=
16120 00000002 c052582c
>> >> [    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 000=
00002 00000000 c0502400
>> >> [    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 000=
00000 00000000 00000000
>> >> [    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 000=
00000 00000000 00000000
>> >> [    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000
>> >> [    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 000=
00000 00000000 00000000
>> >> [    1.111206] Call trace:
>> >> [    1.111328]  software_node_to_swnode from device_add_software_node=
+0x20/0x80
>> >> [    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8=
/0xe4
>> >> [    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
>> >> [    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
>> >> [    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
>> >> [    1.148864]  kernel_init from ret_from_fork+0x14/0x28
>> >> [    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
>> >> [    1.159820] 9fa0:                                     00000000 000=
00000 00000000 00000000
>> >> [    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000
>> >> [    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 000=
00000
>> >> [    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000)
>> >> [    1.191040] ---[ end trace 0000000000000000 ]---
>> >> [    1.196350] Kernel panic - not syncing: Attempted to kill init! ex=
itcode=3D0x0000000b
>> >> [    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill=
 init! exitcode=3D0x0000000b ]---
>> >>
>> >
>> > Thanks. This makes sense. Both omap16xx_gpio_init() and
>> > software_node_init() run as postcore_initcall() so if the order is not
>> > right, it will fail.
>> >
>> > Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
>> > reason to run software_node_init() as a postcore initcall? It only
>> > allocates the kset, can we move it to core_initcall() by any chance?
>> >
>> > Bart
>> >
>>
>> In any case, Aaro: the following should theoretically fix it:
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index 51320837f3a9..5ba904f8a08a 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -1134,7 +1134,7 @@ static int __init software_node_init(void)
>>  		return -ENOMEM;
>>  	return 0;
>>  }
>> -postcore_initcall(software_node_init);
>> +core_initcall(software_node_init);
>
> This is wrong direction IMO. The matching by label is working now, so
> there is no reason to rush this change into the kernel, it is simply a
> cleanup.
>
> Wait until the resolution of my pact allowing using node names, or your
> proposal that installs and attaches nodes dynamically based on bus
> notifiers (or both) and then make the conversion. Then you will not need
> to move init order around, add new dependencies between drivers, and so
> on.
>

Hi Dmitry,

I'm not rushing anything. It's fine to delay this for now. But the new solu=
tion
you're mentioning (whatever it will end up to be) is something we should us=
e
when there's only a lose link between the supplier and consumer. Here both =
the
GPIO controller and the consumer are instantiated from a board file and are
built-in so there's no link-order problem and we can directly reference one
software node from another. It's a different kind of problem.

I'd like to figure out whether software nodes are not made available too la=
te
into the boot process for no reason and if maybe it makes sense to initiali=
ze
them earlier.

Bart
