From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: check pointer before dereference
Date: Tue, 23 Feb 2010 20:11:06 -0600
Message-ID: <4B848ABA.10008@ti.com>
References: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com> <1266530134-8186-2-git-send-email-omar.ramirez@ti.com> <1266530134-8186-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab0BXCLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 21:11:13 -0500
In-Reply-To: <1266530134-8186-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 2/18/2010 3:55 PM, Ramirez Luna, Omar wrote:
> Change the check for valid handle to detect a possible
> error, and now use it before dereferencing the pointer.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   drivers/dsp/bridge/pmgr/msg.c |   16 ++++++++--------
>   1 files changed, 8 insertions(+), 8 deletions(-)
>

Rebased and pushed to dspbridge

- omar

