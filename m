From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
Date: Wed, 16 May 2012 18:17:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com> <1336990730-26892-15-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46385 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975Ab2EQARo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 20:17:44 -0400
In-Reply-To: <1336990730-26892-15-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero

On Mon, 14 May 2012, Tero Kristo wrote:

> save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> otherwise the secure ROM code will crash.

Do we know why the l3_main_3 interconnect has to be enabled?  Is this 
needed to access some L3 or instrumentation registers?


- Paul
