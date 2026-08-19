Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA33AD529;
	Wed, 19 Aug 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152345; cv=none; b=IAYiGTzQJUdV3Lq8jez8vg5dV6tEJ+yRSb//brWwP6/UolT1wXLLHimqR2qw6wHiEjNhPR+DoFgEF1LE2SbdF5dVUMksfQCoI3nNVnE4N1ofdpQX6CC1Xv4o2pq1lsMziHhQd6cZaRINoOIC34Sk+KO2vS9ScRAVDqGrnJZKVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152345; c=relaxed/simple;
	bh=F0fZid40l0eLGgUCdx3f7vhD8ifH42r+dZ6i3UezKMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=O0LuAn6QkiarppGAIzwFvmmxN4wg+Wt/xePVthSxW1KLas+2iKHQHexQ77Hh72ohQ4AFZ44CqJ7NgrsmcOIGSj0P+nvOa5v6ujjakyiUACcQApRf2N2FvLw3YT8IdQLvtnfYsBXO92EppOdbUwZglLopTWPGThP3unSVGiDacAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gyZsMm4O; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gyZsMm4O"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 543D31A1745;
	Wed, 19 Aug 2026 15:12:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25C3F5FF42;
	Wed, 19 Aug 2026 15:12:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1DDD11C7581A;
	Wed, 19 Aug 2026 17:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787152335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+SloCGHTVGckeMQiffsythAoE/mgCLoCC3T/5hhBVhU=;
	b=gyZsMm4OrqcVJgymeLxUFhOs+ZRxEx4bkoQCZq0JsHmQRayE7he8J8jtcJIcrUEd/zlGIA
	Z62w1hxh7V8bHyjN4+lY1DstPc/NRtXiTT7X4mJPX84wLvDXPBLUKzLQljMSpPqUi/JOrM
	1SnZxiSg9isIqDFDNqCWt4HyUL5GbquXqhW/NxJC7odH/meU9G7FoM/d2uXliv/T2vrvpo
	DC8LSZnnwPHLZ9sOcWJNWgKbm6FPnfUu3ZS3/cqfzM5ExJ4ezHnnOgnx0WAGe+qhaxAWhK
	pshOkFSJi7C890YKpSwwINGLIoNbKrQlCcLhK8Sq1amPrgRE+AgjAmBK5dyz3w==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 17:12:12 +0200
Message-Id: <DKT0MN8YMIAT.2ZI006JRL0OJ@bootlin.com>
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Tony Lindgren" <tony@atomide.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
 <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com>
 <DKSOGEFQ4RJA.3LEW2Y8991H17@bootlin.com>
 <CAMuHMdVfFZ0P9Na-yD9EzBaUqkyiwjo8byxA2MouBt1DM8xQtA@mail.gmail.com>
In-Reply-To: <CAMuHMdVfFZ0P9Na-yD9EzBaUqkyiwjo8byxA2MouBt1DM8xQtA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert,

On Wed Aug 19, 2026 at 2:32 PM CEST, Geert Uytterhoeven wrote:
> Hi Mathieu,
>
> On Wed, 19 Aug 2026 at 07:39, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>> On Tue Aug 18, 2026 at 6:02 PM CEST, Geert Uytterhoeven wrote:
>> > On Mon, 27 Jul 2026 at 09:44, Mathieu Dubois-Briand
>> > <mathieu.dubois-briand@bootlin.com> wrote:
>> >> Resolve parent clocks by their index into the device tree "clocks"
>> >> property rather than matching names as strings. Name-based matching i=
s
>> >> fragile because a clock's "clock-output-names" value in its provider
>> >> node can differ from the name used to reference it in a consumer node=
,
>> >> and because names must be globally unique across all clock providers.
>> >>
>> >> On AM335x, this caused broken clock trees where some clocks failed to
>> >> enable because their parents could not be found.
>> >>
>> >> Replace of_clk_parent_fill() with a clk_parent_data array that sets
>> >> .index to the array position.
>> >>
>> >> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
>> >> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.c=
om>
>> >
>> > Thanks for your patch, which is now commit 667f420c09f1417c ("clk: ti:
>> > mux: resolve parent clocks by DT index, not by name") in clk/clk-next.
>> >
>> > This breaks booting BeagleBone Black for me: I don't get any output
>> > on the serial console, even with "earlycon keep_bootcon".  When the
>> > watchdog kicks in (or on kernel panic?), the system reboots.
>>
>> Sorry for that!
>>
>> It's a bit unexpected, as the beaglebone black was one of my test
>> platforms and I didn't see any issue.
>>
>> > Reverting this commit fixes the issue.
>> > After reverting, I added debug code to print all parents, and compared
>> > them to the DTB, but didn't see any discrepancies.
>> >
>> > Your similar change to drivers/clk/ti/composite.c does not cause any
>> > issues for me.
>> >
>> > Do you have a clue?
>> > Thanks!
>>
>> Can you describe what bootloader and device tree you are using for your
>> tests? Any specific configuration?
>>
>> On my side, I have:
>> - BeagleBone Black Wireless A5
>> - am335x-boneblack-wireless.dtb
>> - U-boot 2025.10-ti-g6825d60bea17. Maybe I should try with u-boot master
>>   branch.
>
> BeagleBone Black Rev C3 (by Seeed Studio)
> am335x-boneblack.dtb
> Stock U-Boot SPL 2019.04-00002-g31a8ae0206 (May 13 2020 - 09:26:17 -0500)
>
> I am using my own config.
>
> With omap2plus_defconfig and multi_v7_defconfig, it does boot.  However,
> this commit does have an impact on /sys/kernel/debug/clk/clk_summary:
>
> --- summary-7.2.0-rc2-00106-g0d4d262c1664       2026-08-19
> 10:56:51.622275674 +0200
> +++ summary-7.2.0-rc2-00107-g667f420c09f1       2026-08-19
> 10:58:13.929823890 +0200
> ...
>
> I.e. wdt1_fck changed its parent from clk_rc32k_ck to
> clk-24mhz-clkctrl:0000:0, which is probably not intended?
>

This was definitely not intended, but I believe this is a valid
configuration.

wdt1_fck has two potential parents. In the device tree
(am33xx-clocks.dtsi), we have:

	wdt1_fck: clock-wdt1-fck@538 {
		...
		clocks =3D <&clk_rc32k_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_C=
LKCTRL 0>;
		...
	};

As I understand it, the kernel is free to select any of the parents
here. Is that correct?

Previously, the link with the second parent was broken, and only the
first parent was known. That was my initial issue that triggered my
changes. Now, both parents can be selected. I assume the second one is
seen as a better option for some reason, and so now it is selected.

But maybe my assumption are wrongs, so feel free correct me here.

> However, that is not the cause of the crash.  My .config has
> CONFIG_INIT_STACK_ALL_PATTERN enabled, so any uninitialized local
> variables contain garbage.
>
>> @@ -136,7 +136,7 @@ static struct clk *_register_mux(struct device_node =
*node, const char *name,
>>         init.name =3D name;
>>         init.ops =3D &ti_clk_mux_ops;
>>         init.flags =3D flags;
>> -       init.parent_names =3D parent_names;
>> +       init.parent_data =3D parent_data;
>>         init.num_parents =3D num_parents;
>>
>>         /* struct clk_mux assignments
>
> Init is not fully initialized, hence init.parent_names contains garbage
> (before, .parent_data contained garbage).
> As clk_core_populate_parent_map() prioritizes .parent_names over
> .parent_data, the uninitialized .parent_data didn't cause any harm before=
.
>

Nice catch. I didn't realise that while doing my changes.

Thanks for taking the time to track this issue.

Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

