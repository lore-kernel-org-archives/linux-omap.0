From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 10:55:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106271053000.460@utopia.booyaka.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com> <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com> <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
 <20110627101427.GH23145@atomide.com> <alpine.DEB.2.00.1106270910210.460@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB593024D793501@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41101 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1F0QzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 12:55:18 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D793501@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, 27 Jun 2011, Premi, Sanjeev wrote:

> [sp] Can you look at my query to Tony? Will that be an acceptable
>      workaround until DT. Going to two machine IDs and then unifying
>      back again could cause confusion - esp. during transition times.

It's up to Tony, he's the maintainer...


- Paul
