From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/2] DSPBRIDGE: fix a wrong clk index for gpt8
Date: Mon, 14 Jun 2010 12:59:24 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E872E47@dlee03.ent.ti.com>
References: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445Ab0FNR7Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 13:59:25 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5EHxPF8004337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:25 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o5EHxOrg027519
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:24 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5EHxOpT006364
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:24 -0500 (CDT)
In-Reply-To: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Hebbar, Shivananda" <x0hebbar@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>

>From: Ramirez Luna, Omar
>
>Mismatch between index for gpt clocks will result in writting
>out of bounds into dsp clock timer array when requesting gpt8,
>for the other gpt the bogus code is being masked as it falls
>within the array's range.
>
>Discovered-by: Ernesto Ramos Falcon <ernesto@ti.com>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/core/dsp-clock.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>

Pushed to dspbridge.

- omar
