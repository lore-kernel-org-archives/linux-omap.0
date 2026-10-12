Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E28477998;
	Mon, 12 Oct 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814916; cv=none; b=JpOZlQ32/K8v2ddHvfCsfhM1lfazV+aOZbdF9pOHCD9PjjGYc0FYTp5w87+2CxJ665Eiq8wzLqEEQzhLzkHQIQGoFA8SyAr2ohI3cFo3Yk//lNqqPzq4UVOS8O8zUSUyD1MbnumID75EDhRO1ZF0BSh30LtbZRza2iTMXZr0umQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814916; c=relaxed/simple;
	bh=Vg8qtqe35r+n7+lLL9hjcQLC1/Pn3jMa4OL43xmJpNU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l4IZYhmona3FzVu9tS4qnT0kVcurkbKafroGgGD+RFuzTsdGkZILiVyK3aBRXT+TfXSFCk9VD125VpaxM54QX8wZdUhdA+HP4xk3GGgzE15uw83WGewRAyDx9zTSe2C1Q4swVVcPNi0y6vsPCUZCNk05gK25AuB/LyNoEQ7OtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZyJysnj5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZyJysnj5"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9B45D80ED7;
	Mon, 12 Oct 2026 16:21:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzAE_5ILlWc4; Mon, 12 Oct 2026 16:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791814911; bh=Vg8qtqe35r+n7+lLL9hjcQLC1/Pn3jMa4OL43xmJpNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZyJysnj5rjc1lVTrs77e8lt1BEF1SCkcnNroAuCIyd12rJCXnTtv5R3SUoXtDP/iq
	 LrajYNqBaRXzxM9dP0hyFlEneq0/gGSrAmgMcrZTZE1bvxD4WwaXAW+BrlO5D/52up
	 kPDZ64nVBHhWPzKKWTFxy55yrTrsRNi8RpyhNXfKUFv4k6OK5YwJr07gKXsG5QnCHb
	 NNtQV4PKZpyYwFTdalGhw0e5XWbto0GeCdyp4aiun9qXbIUcFv83Oq/1sUYD+BxWV0
	 H1Ez050OLQGbhVL1gRjaLMZdRbZyqUsWe8vtGFQNnhe+6irsu2OXufiQ2MrwYeyUEB
	 BS412UTqakOLA==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 14:21:51 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang
 <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: single: add big endian support
In-Reply-To: <CAD++jLnTOc+n2PGpK1NDnNJXwgzTQ8shO_6NqNuADzxY8SyYsA@mail.gmail.com>
References: <20261010175721.76213-1-adilov@disroot.org>
 <CAD++jLnTOc+n2PGpK1NDnNJXwgzTQ8shO_6NqNuADzxY8SyYsA@mail.gmail.com>
Message-ID: <03f84f8678f0a6a09e10e57c77ce82f9@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-10-11 20:14, Linus Walleij wrote:
> On Sat, Oct 10, 2026 at 7:57 PM Rustam Adilov <adilov@disroot.org> wrote:
> 
>> Add support for big endian pin controllers by taking into account
>> a big-endian device tree property.
>>
>> This is needed on big endian MIPS platforms like RTL930X, RTL931X
>> and RTL9607C who use pinctrl-single, because when SWAP_IO_SPACE is
>> enabled, the mmio accessors in pinctrl-single perform a byte swap.
>>
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
> 
> I'm not so sure about expanding the usage of pinctrl-single, we have
> said that this is used in the cases when you want to stash all the
> hardware data into the device tree (such as which groups and functions
> that exist) and it seems mostly done to save memory for the kernel
> so you don't need to compile in that data for all systems.
> 
> The argument that this is "simple" if you just have some hardware
> data in a file is moot these days IMO, because you can now just
> give that data to an LLM and it will spit out any group and function
> definitions you want.
> 
> So I'd like to hear some of the reasoning about why you want to
> do this thing, we have other drivers doing this but without using
> pinctrl-single.

Um, what? I don't understand how that is related to anything with my
commit message.

In MIPS context, SWAP_IO_SPACE is only about [1].

[1] - https://elixir.bootlin.com/linux/v7.2.9/source/arch/mips/include/asm/mach-generic/mangle-port.h#L28

> One of the driver maintainers have to ACK it too.
> 
>> +static unsigned int pcs_readw_be(void __iomem *reg)
>> +{
>> +       return ioread16be(reg);
>> +}
>> +
>> +static unsigned int pcs_readl_be(void __iomem *reg)
>> +{
>> +       return ioread32be(reg);
>> +}
>> +
>> +static void pcs_writew_be(unsigned int val, void __iomem *reg)
>> +{
>> +       iowrite16be(val, reg);
>> +}
>> +
>> +static void pcs_writel_be(unsigned int val, void __iomem *reg)
>> +{
>> +       iowrite32be(val, reg);
>> +}
> 
> Why this indirection? Can't you just assign the standard
> accessors directly?

To mirror the normal pcs_read/write? And yes we can just as easily
assign them to io functions directly.

>>         case 16:
>> -               pcs->read = pcs_readw;
>> -               pcs->write = pcs_writew;
>> +               if (byte_be) {
>> +                       pcs->read = pcs_readw_be;
>> +                       pcs->write = pcs_writew_be;
>> +               } else {
>> +                       pcs->read = pcs_readw;
>> +                       pcs->write = pcs_writew;
> 
> Maybe they should all do that actually, can't we rewrite
> this so we just:
> 
> if (byte_be) {
>   pcs->read = ioread16be;
>   pcs->write = iowrite16be;
> } else {
>   pcs->read = ioread16;
>   pcs->write = iowrite16;
> 
> I don't see how the wrappers help and I hope the compiler
> just optimize them away anyway.

A little out of scope but i am cool with a extending this patch to
a 2 part series to do that.

Best,
Rustam
