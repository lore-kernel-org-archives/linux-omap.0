Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85193A0EBA;
	Wed,  4 Feb 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196068; cv=none; b=g2mu727WohyLVoK9cY9OVCT+Bj0M2cYxqddXizjYhnIg82a3JRNKOhPEf1uu5h5kTiEjrnWRImAMZ83uvL8fBuuY2jaF9H5Y2JnH59gN8hVlfAA6vIMANArdJqR+Kvl9Aq9bWD+5rwDEWinaq4s/52a7khBgK8Q6/zNKaUrDq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196068; c=relaxed/simple;
	bh=Z3zMC4MQxGZg0jA5Y/8DsGyq+tlx9ZqNm1voZHu2z5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHQKjToLEb9AAsCQKhX4X6zgwSnXA2Bg2Fypxk5knz51ZjOS3LfvhwzWaq9R9Rxb+v3CJdW0IcgO3emnSuYAjqWks6ScFnazOvE/eqhvWZrPSZMNFuhTw4Ogj993vvtisUjPWS/MsJFuGv4uRa5mGqFMzLIqtznQXMSU0GXmlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=shttYJZ7; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="shttYJZ7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hDYEr87uD7421qYjDNk4fZncRRUE4KkHMxbUB1O9BkE=; b=shttYJZ7VYmOxtT1tTs+iK2G68
	kstUtUCJpDUq7j5z92nQDmdpt/LbuRMBUI7YS5WGpsrbbAQoc6wzjcCbVOJKj/3fjV1m8prFG7a/P
	WTHN0yWBC+hr9Vk7SI9ef3oYXZuqkfdA0ywjxruqxUb8GJbLftwo4pNo1iqQjUWP6AiL41PX1ZWcb
	QQh+FKWYkfIvRW8T33RQlrYOvC5Tu9wdHKQbzxoP41xbhlUtGRl/xY7w37vSU+0Q6ZUhQpVTORpcd
	+YXiyswSa4g0UWRtgkNYVrQptKpZsFi5O+DRB4frz/I5q0bLjPjH5NpqSS68e5y2qIRJa8rpjUm8t
	xg2tpfVA==;
Date: Wed, 4 Feb 2026 10:07:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: aaro.koskinen@iki.fi, airlied@gmail.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, khilman@baylibre.com,
 krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, robh@kernel.org,
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com,
 tony@atomide.com, tzimmermann@suse.de
Subject: Re: [PATCH v5 5/8] ARM: dts: ti: omap: espresso-common: Add common
 device tree for Samsung Galaxy Tab 2 series
Message-ID: <20260204100730.0fcc6b46@kemnade.info>
In-Reply-To: <20260204074831.300311-1-bavishimithil@gmail.com>
References: <20260202090408.4c3757cb@kemnade.info>
	<20260204074831.300311-1-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Feb 2026 02:48:31 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> > We had the discussion. This should be done via pinctrl irq if possible instead of
> > specifying WAKEUP_EN here, You had some trouble to understand how it can be done,
> > and we agreed to add the wakeup functionality as a follow-up concentrating just
> > on that detail and for now just remove WAKEUP_EN.  
> 
> I think I may have understood what is to be done.
> For example we have 
> pinctrl-single,pins = <
> 	OMAP4_IOPAD(0x0bc, WAKEUP_EN | PIN_INPUT | MUX_MODE3)
> >;  
> 
> for wlan_host_wake, so the change needed to be done is from
> interrupt-parent = <&gpio3>;
> interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> interrupt-names = "host-wake";
> pinctrl-names = "default";
> pinctrl-0 = <&wlan_host_wake>;
>
we still need the pinctrl. Just the WAKEUP_EN flag gets managed via the
pinctrl interrupt handling.
 
> to
> \.
> interrupts-extended = <&gpio3 17 IRQ_TYPE_LEVEL_HIGH>, 
> 			<&omap4_pmx_core 0x0bc>;
<&omap4_pmx_core 0x7c>

offset is from beginning of padconf area, so from
0x4A10 0040, you can see that from.

In omap4-l4.dtsi:
omap4_pmx_core: pinmux@40 {
                                compatible = "ti,omap4-padconf",
                                             "pinctrl-single";
                                reg = <0x40 0x0196>;


The OMAP4_IOPAD macro handles the offset, so you have
different values there.

> interrupt-names = "host-wake", "wakeup";
> 
> and remove the pinctrl?

just remove the WAKEUP_EN flag from there.

> Similarly for all in the omap4_pmx_core domain (wifi, bt, i2c as the
> drivers support it)
> No chnages for &omap4_pmx_wkup domain
> 
The gpio instance in that domain is always-on anyways, so we do not need
any additional wakeup mechanism there.

Regards,
Andreas
