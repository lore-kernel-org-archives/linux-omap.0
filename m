Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52630D418;
	Wed, 19 Aug 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787117999; cv=none; b=AV4odYwGxo/wzoEM3WS2gv2moJCI5CwmoIY81ZDfobPWrxGyt36qeNC8QAHgCrMOyDr7z5fFDV37ITTO1INCiDoIxF8mOd5usYFmEyP3KmXx+bvjNO5hx+H0Z7ExzWmjl2an0xAdMmvCNKjZX2Z4sSabPZXWs2mV5vyDPX0F2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787117999; c=relaxed/simple;
	bh=WAFEdBjBZdA9pSuIrw5b5MRDn06xdtbC5evyrWBdFB8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=GOa10Iyk7CrNC0kSbAdb0igfbHUHYF6AaE7O0Z/L4wTeF3UILbfSBFCFgDLfqXRD8NQDlh0I+MtleNzKd068NEq92Ru2N2WaEbnR7IsJ92lxfft3xuRpuG9AkBTrKPbpxm4WMItT3f46fM3/F9pfcRBA8RJ+n6mzO93eyu3aS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zly0of4k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zly0of4k"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A99921A1721;
	Wed, 19 Aug 2026 05:39:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75F59604AA;
	Wed, 19 Aug 2026 05:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0646B11C752A4;
	Wed, 19 Aug 2026 07:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787117992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FhXOKgDtnkU3HSTLbDpgInOX86Wa95GP1B82H7rsb5o=;
	b=Zly0of4k/GiE0/jeo+8zwk+jjetKtB76mRHlL43louPV3YkEjNReacw5eIK+Dtw9DYtjL6
	NKuVyW/rSJYTp7sbpmI9y7LCk0KBVe7L4kXzXxhrpzDS7lL/AEJpTLMq3mecL2MVt0RXCL
	nHU4wwMQoLmR6LRz8CrXrbPAVq8NUOwnfNgLLjsScFqWhxIbwLJH1qnZog0ux/3NgwsF8o
	LYJUGY7t8m6BSXHvS7ApSc25IfADBeHdCIH0DB3x1efTnTV4Gt8Zn4OqiPEl/dEl17hAMz
	f9iuQ43ysJWMzUFpQVCFXKbuSJ5pjryzHTziGYXhhayCj86Ea5xGtI0eSUC3eg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 07:39:49 +0200
Message-Id: <DKSOGEFQ4RJA.3LEW2Y8991H17@bootlin.com>
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
In-Reply-To: <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert,

On Tue Aug 18, 2026 at 6:02 PM CEST, Geert Uytterhoeven wrote:
> Hi Mathieu,
>
> On Mon, 27 Jul 2026 at 09:44, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>> Resolve parent clocks by their index into the device tree "clocks"
>> property rather than matching names as strings. Name-based matching is
>> fragile because a clock's "clock-output-names" value in its provider
>> node can differ from the name used to reference it in a consumer node,
>> and because names must be globally unique across all clock providers.
>>
>> On AM335x, this caused broken clock trees where some clocks failed to
>> enable because their parents could not be found.
>>
>> Replace of_clk_parent_fill() with a clk_parent_data array that sets
>> .index to the array position.
>>
>> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>
> Thanks for your patch, which is now commit 667f420c09f1417c ("clk: ti:
> mux: resolve parent clocks by DT index, not by name") in clk/clk-next.
>
> This breaks booting BeagleBone Black for me: I don't get any output
> on the serial console, even with "earlycon keep_bootcon".  When the
> watchdog kicks in (or on kernel panic?), the system reboots.
>

Sorry for that!

It's a bit unexpected, as the beaglebone black was one of my test
platforms and I didn't see any issue.

> Reverting this commit fixes the issue.
> After reverting, I added debug code to print all parents, and compared
> them to the DTB, but didn't see any discrepancies.
>
> Your similar change to drivers/clk/ti/composite.c does not cause any
> issues for me.
>
> Do you have a clue?
> Thanks!

Can you describe what bootloader and device tree you are using for your
tests? Any specific configuration?

On my side, I have:
- BeagleBone Black Wireless A5
- am335x-boneblack-wireless.dtb
- U-boot 2025.10-ti-g6825d60bea17. Maybe I should try with u-boot master
  branch.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

