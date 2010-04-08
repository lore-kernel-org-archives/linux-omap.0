From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues
Date: Thu, 8 Apr 2010 08:58:00 -0700
Message-ID: <l2v5e088bd91004080858ub5dd068ci711a5399098ba0ee@mail.gmail.com>
References: <ce9ab5791001060558u362f17baj5ee90e9b4adb72a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:29848 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757214Ab0DHP6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 11:58:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so846316qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 08:58:00 -0700 (PDT)
In-Reply-To: <ce9ab5791001060558u362f17baj5ee90e9b4adb72a7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Wed, Jan 6, 2010 at 5:58 AM, Vimal Singh <vimal.newwork@gmail.com> w=
rote:
> From 3700088e8da8c890d9e4c6eb626e18287d149b97 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 5 Jan 2010 16:43:08 +0530
> Subject: [PATCH] fixing omap nand driver issues
>
> fixing omap nand driver issues.
>
> Vimal Singh (3):
> =A0Fixing compilation warning for 'nand/omap2.c'
> =A0NAND: OMAP: correct 'info' pointer in 'omap_nand_remove'
> =A0NAND: OMAP: Fixing issue in oamp nand driver in prefetch mode read

What is the status of this patch series?

I've been testing them on Overo and Beagle and they do indeed solve
the prefetch issue.  So if they are queued waiting an ack:

Acked-by: Steve Sakoman <steve@sakoman.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
