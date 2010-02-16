From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RESEND] [PATCH] DSPBRIDGE: Adding protection Resource cleanup
 linked lists
Date: Tue, 16 Feb 2010 17:56:38 -0600
Message-ID: <4B7B30B6.5040800@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA725DC6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44408 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933636Ab0BPX4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:56:40 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA725DC6@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On 2/10/2010 2:32 AM, Guzman Lugo, Fernando wrote:
>
> Please discard previous one.
>
> Regards,
> Fernando.
>
>  From 6bcdc02f6265246e385194433775e75db7ad44cf Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Wed, 10 Feb 2010 02:31:40 -0600
> Subject: [PATCH] DSPBRIDGE: Adding protection Resource cleanup linked lists
>
> This patch protects the Resorce cleanup lists from
> concurrent access
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>


Removed wcd.c changes as functions affected doesn't exist.

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
