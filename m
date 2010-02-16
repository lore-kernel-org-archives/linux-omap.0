From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Avoid inserting wrong elements to STRM list
Date: Tue, 16 Feb 2010 17:56:45 -0600
Message-ID: <4B7B30BD.9010609@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA725DC7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933636Ab0BPX4u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 18:56:50 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA725DC7@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On 2/10/2010 2:34 AM, Guzman Lugo, Fernando wrote:
>  From 09260a0211d088d840d09c04380c8c9448c01ec4 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Wed, 10 Feb 2010 02:33:54 -0600
> Subject: [PATCH] DSPBRIDGE: Avoid inserting wrong elements to STRM list
>
> This fixes a bug where in error case and after deleting a
> strm element (if allocated), the strm is still inserted as
> part of the process context allocated resources, this pointer
> is not valid and shouldn't be considered as part of valid
> resources.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
