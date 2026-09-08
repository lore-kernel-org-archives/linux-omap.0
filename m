Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE971C8FB1;
	Tue,  8 Sep 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825676; cv=none; b=KIrqXdYWPDnyAcOIevIGgTp3UQcqIhE8sbtxYC2gjbPKUsZLSTXIXR1xFf/y3WOekvKEhkmbAE9Vn04x3jHKWdTbI4psomlfbdbL46PU/qas15XAxlgG4vxJeXFddfnPKo12a7ZzqvZbFrq4qs+M/52eh7Ajobp9yE1NNSw9jiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825676; c=relaxed/simple;
	bh=tXiqMqDakfvlY2dupDubgTSMtlJnNbg4eRmckHJ+NEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K48S/kuwsEEmrDtitlanH+mnoHvhIfm1DgnPdsJjvHXNEiRM5KP5NsDYffYZ3yLYCyZ4yHzTG5VxBDkQXaUYe2I3yAqOpSQaMMrWeehsv78SwN1QDbIhz3kD97lKJjpQCZVdp8E2nmYKvMHPCOAoG0kACRxuIaX99ZCCk7LK2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QieT0c/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QieT0c/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67B1F00A3D;
	Tue,  8 Sep 2026 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825675;
	bh=bcbXPgqqmhCGAYehVpdlPlHAVlBttNgjeXnR1sVfUjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QieT0c/hEJuFm2V6fmOk29kMSBvFDbkIgsgSb6O2FnZgG/eWwIBwY7a7zrFi22m2e
	 kbRJ5PRU2DEGfr8SpR3aD9y3j8k1lJAjt/6D5wx12NqREIHoI8WVA3H6bRDQxMVV3t
	 MzOztgSXL1SfVGaG6oz82vSAuWh+VgCZQ08/lpuqhfzQQ+NfN5Fghwss5du/mdjlK0
	 MGahfnhuHRV6OjOqoRger4y85JkAE3DOkBN3iWLnQGNZ8Sl/EVjajesxaScF6FEzBn
	 E3Wivo9yluKmAC0megzUZptoDMe1OTCA+yP+K5CH1kvgt4gO+uE1vRTOV8S70Gf/Vb
	 iUHZh9IHG5XfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3039E8A5A;
	Tue,  8 Sep 2026 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/33] Remove comma after sentinel entries in
 match
 table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882561388.3212362.1851608781908345741.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:00:13 +0000
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de,
 mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
 linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com,
 clement.leger@bootlin.com, justin.chen@broadcom.com, dlan@kernel.org,
 rogerq@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, amadeus@jmu.edu.cn,
 kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, daniel.zahka@gmail.com,
 nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com,
 haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com,
 lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-omap@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Sep 2026 10:06:06 +0530 you wrote:
> Hello,
> 
> This series removes the comma present after sentinel entries in the match
> tables across all networking subsystem drivers, with the exception of the
> davinci_mdio.c driver, for which, the patch posted by Geert at:
> https://lore.kernel.org/r/e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be/
> does the same.
> 
> [...]

Here is the summary with links:
  - [net-next,01/33] can: bxcan: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/3fb94a277ff8
  - [net-next,02/33] can: c_can: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/fa7291a2527a
  - [net-next,03/33] can: flexcan: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/4b7e7da65530
  - [net-next,04/33] can: ifi_canfd: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/e6f3617decf3
  - [net-next,05/33] can: m_can: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/6c507ab36a83
  - [net-next,06/33] can: sja1000: f81601: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/44ef827c95a8
  - [net-next,07/33] can: sja1000_platform: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/5b01d5766043
  - [net-next,08/33] net: dsa: b53: mdio: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/9869b64b320d
  - [net-next,09/33] net: dsa: b53: srab: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/30fccb0c4e76
  - [net-next,10/33] net: dsa: bcm_sf2: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/2d08ac30e2ed
  - [net-next,11/33] net: dsa: hellcreek: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/4ea4ec365378
  - [net-next,12/33] net: dsa: lan9303: i2c: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/a650dd1fc254
  - [net-next,13/33] net: dsa: lan9303: mdio: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/4caa67d082f6
  - [net-next,14/33] net: dsa: mxl-gsw1xx: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/9a580b3496c4
  - [net-next,15/33] net: dsa: mt7530: mdio: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/e86151633076
  - [net-next,16/33] net: dsa: mt7530: mmio: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/f9bcf01a6608
  - [net-next,17/33] net: dsa: mv88e6060: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/6011d062dc7d
  - [net-next,18/33] net: dsa: mv88e6xxx: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/ead589471593
  - [net-next,19/33] net: dsa: qca8k: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/c45695468377
  - [net-next,20/33] net: dsa: realtek: rtl8365mb: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/6233d1ee3771
  - [net-next,21/33] net: dsa: realtek: rtl8366rb: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/068d6ebde398
  - [net-next,22/33] net: dsa: rzn1_a5psw: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/39063420326f
  - [net-next,23/33] net: dsa: sja1105: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/2b46b5c9efc9
  - [net-next,24/33] net: bcmasp: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/a450f7315155
  - [net-next,25/33] net: spacemit: k1_emac: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/435d4b4aa9c8
  - [net-next,26/33] net: ti: am65-cpsw-nuss: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/8b7eacd62198
  - [net-next,27/33] net: ethernet: ti: cpsw: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/1cdf69f1e9a0
  - [net-next,28/33] net: ethernet: ti: cpsw_new: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/6d1c7d7a0731
  - [net-next,29/33] net: mdio: bcm-iproc: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/93b9f4f13608
  - [net-next,30/33] net: mdio: bcm-unimac: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/dd7a0a755874
  - [net-next,31/33] net: pcs: xpcs-plat: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/3fc32eb28f15
  - [net-next,32/33] net: phy: nxp-c45-tja11xx: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/af86c0a58007
  - [net-next,33/33] net: wan: slic_ds26522: Remove comma after sentinel-entry in match-table
    https://git.kernel.org/netdev/net-next/c/8afd6adb0717

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


