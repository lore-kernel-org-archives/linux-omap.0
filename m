Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2B31618C
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632430; cv=none; b=NPFCrsssOsC1cUI24ghK6xBQrVNGO3yqeBTHaDSkbdAbAxVBdUPS/kpTS2E7KIwHoC8DEZXPVGiGv4iLztVEP6elIZ4n6a91fDqa00WD5qgdsbiZCzqctt3ceP3k5LT7eyZ2HnGSszm1EysUxQmd6XAKaueUHvSam/wjZAiPrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632430; c=relaxed/simple;
	bh=eMKH+40dSjMtLqvxvxWCSOCjTU/WAJA2oHSZ/A5hsR4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2OJBIplC6o0G+hMj6Fxqzh9j0dnr668ptF65E7O54zsD/IJ/pEXyLznkBSpcwdQVzS14SClhrF2p5UQdI2rP+eFtZrsp+emreACmTWLyvl/3t6cPVbVFQh1DyJNKABWnjB7p7XBYUyq/qNGEP1C/HRW8+ktXzeBUux0dkSPFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwG84AtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwG84AtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E0C2BCB0
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774632430;
	bh=eMKH+40dSjMtLqvxvxWCSOCjTU/WAJA2oHSZ/A5hsR4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=OwG84AtSevxyWcXb19eDI0S13Ii5zGBbneQiq879ObtbloAQtse7BEBse354N4CPM
	 bkltfXHFFY2t9Ep+s3962tdsnXNhnjV43TX92R5OhG855/qCPFH17rugWJbanI9V8V
	 +l7sCqi7Wm4ilipTY1Tmw4F3uVNwC0uLHj9Nr6LQSSycyQSKQXYKjxeIHvng37h/p6
	 AzerbAyUdFmJ4xq1eRLF/lboC52vxhWotjqekSUhxDlMAvuSSbbnVv/peLjrhXxRag
	 tb5/IUC3TQD4wFHramW1Xziklm5SMHs4Hj9SUFHo827UuH1Uq3j7K+BziyH/T+ATFw
	 kZot6kJGohnNQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so3002426e87.1
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 10:27:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhjf3xHbk9tudHbb04t+nlj7G1yGOwaDtJ9gUuC49K9Nn6gms1fGVVYMRtMtt0Y8KGCrwIfv/JOLm1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5rO7lHkJTCT4GY8knW314yv9+UCQhyV1IgDhd+gz+fD72A/z
	Pi8hMW+0LBFQeVLkonMlU6AFGA6zQKVCNfy3tHkZs3FzTjiYg/7Na9EdkmuRq2+7RjQVM92CmJS
	krsVLlPrt3oKkOODmbDWxVDC7U5gEvQQw2zfl+TUWRg==
X-Received: by 2002:a05:6512:1288:b0:5a1:18e9:a361 with SMTP id
 2adb3069b0e04-5a2ab927a32mr1601271e87.32.1774632429204; Fri, 27 Mar 2026
 10:27:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Mar 2026 10:27:07 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Mar 2026 10:27:07 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com> <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi> <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi> <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
Date: Fri, 27 Mar 2026 10:27:07 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>
X-Gm-Features: AQROBzBFL3k-pSjLqyL79AX9w3CeRs-LC8fKlF3aOyiPrJn21a8pJs-NXP_lBBo
Message-ID: <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 18:23:29 +0100, Bartosz Golaszewski <brgl@kernel.org> s=
aid:
> On Fri, Mar 27, 2026 at 5:59=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.=
fi> wrote:
>>
>> Hi,
>>
>> On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
>> > Hmm, I'm wondering if there's a race with consumers already requesting
>> > the GPIOs after the controller device is registered but before the
>> > software node is added. I'll send a version with software nodes being
>> > registered first, then passes as firmware nodes to the platform device
>> > API before the device is registered.
>>
>> It crashes early, I was able to get an UART log from OSK (another
>> 16xx board):
>>
>> [    1.001525] Register r12 information: 2-page vmalloc region starting =
at 0xc2808000 allocated at kernel_clone+0xa4/0x20c
>> [    1.013092] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
>> [    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
>> [    1.024230] 9ec0:                                     c072d000 c05294=
74 c06b3aa0 c050a3cc
>> [    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c072d0=
00 00000000 c0503160
>> [    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 ffffff=
ff 00010000 946f70b5
>> [    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c072d0=
00 c04da8f8 c0060a18
>> [    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c08161=
20 00000002 c052582c
>> [    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 000000=
02 00000000 c0502400
>> [    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 000000=
00 00000000 00000000
>> [    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 000000=
00 00000000 00000000
>> [    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000
>> [    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 000000=
00 00000000 00000000
>> [    1.111206] Call trace:
>> [    1.111328]  software_node_to_swnode from device_add_software_node+0x=
20/0x80
>> [    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8/0x=
e4
>> [    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
>> [    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
>> [    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
>> [    1.148864]  kernel_init from ret_from_fork+0x14/0x28
>> [    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
>> [    1.159820] 9fa0:                                     00000000 000000=
00 00000000 00000000
>> [    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000
>> [    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 000000=
00
>> [    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000)
>> [    1.191040] ---[ end trace 0000000000000000 ]---
>> [    1.196350] Kernel panic - not syncing: Attempted to kill init! exitc=
ode=3D0x0000000b
>> [    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill in=
it! exitcode=3D0x0000000b ]---
>>
>
> Thanks. This makes sense. Both omap16xx_gpio_init() and
> software_node_init() run as postcore_initcall() so if the order is not
> right, it will fail.
>
> Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
> reason to run software_node_init() as a postcore initcall? It only
> allocates the kset, can we move it to core_initcall() by any chance?
>
> Bart
>

In any case, Aaro: the following should theoretically fix it:

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9..5ba904f8a08a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1134,7 +1134,7 @@ static int __init software_node_init(void)
 		return -ENOMEM;
 	return 0;
 }
-postcore_initcall(software_node_init);
+core_initcall(software_node_init);

 static void __exit software_node_exit(void)
 {

If you could give it a spin and let me know if it does, it would be awesome=
.

Bart
