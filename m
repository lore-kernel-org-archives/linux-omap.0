From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Add BRD_SLEEP_TRANSITION in PROC_GetState
Date: Tue, 16 Feb 2010 17:48:55 -0600
Message-ID: <4B7B2EE7.5000505@ti.com>
References: <B852767254C5C94EBB1040EE0EFA06008C89EB85@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643Ab0BPXtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:49:01 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C89EB85@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

On 2/9/2010 1:19 PM, Ramos Falcon, Ernesto wrote:
>  From 40d5863c3d3f4091761fef8bff581d2a7b1f32fa Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos<ernesto@ti.com>
> Date: Tue, 2 Feb 2010 20:30:19 -0600
> Subject: [PATCH] DSPBRIDGE: Add BRD_SLEEP_TRANSITION in PROC_GetState.
>
> When PROC_GetState checks for BRD status it is not taking into account
> the state BRD_SLEEP_TRANSITION and it is returning DSP_EFAIL when this
> happens, which is wrong. This fix adds this check to return ProcStatus as
> PROC_RUNNING and status DSP_SOK when this happens.
>
> Signed-off-by: Ernesto Ramos<ernesto@ti.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
