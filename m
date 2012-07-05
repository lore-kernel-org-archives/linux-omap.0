From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] remoteproc: adopt the driver core's alloc/add/del/put
 naming
Date: Wed, 04 Jul 2012 19:50:47 -0700
Message-ID: <4FF50107.8030406@codeaurora.org>
References: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14877 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab2GECuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 22:50:51 -0400
In-Reply-To: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, =?UTF-8?B?U2p1ciBCcsOmbmRlbA==?= =?UTF-8?B?YW5k?= <sjur.brandeland@stericsson.com>

On 7/4/2012 6:36 AM, Ohad Ben-Cohen wrote:
> To make remoteproc's API more intuitive for developers, we adopt
> the driver core's naming, i.e. alloc -> add -> del -> put. We'll also
> add register/unregister when their first user shows up.
>
> Otherwise - there's no functional change here.
>
> Suggested by Russell King <linux@arm.linux.org.uk>.
>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
