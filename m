From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Mon, 29 Oct 2012 13:39:09 +0530
Message-ID: <508E39A5.1060300@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <508895D8.5000701@ti.com> <5088F19B.7050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45547 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787Ab2J2IJP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 04:09:15 -0400
In-Reply-To: <5088F19B.7050606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

Hi Daniel,

On Thursday 25 October 2012 01:30 PM, Daniel Mack wrote:

> Hmm, that number is currently hard-coded in GPMC_CS_NUM. It would take
> some effort to make that dynamic but I agree that this would be a good
> thing to have. Afzal?

It would be good to have (to the best of my knowledge
am335x has only 7 pinned out, even though IP has 8)

Regards
Afzal
