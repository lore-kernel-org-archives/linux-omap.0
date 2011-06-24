From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 09/12] OMAP3: Serial: Remove uart pads from 3430 board file.
Date: Fri, 24 Jun 2011 15:29:22 -0700
Message-ID: <8739iyx3r1.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-10-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:55504 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757115Ab1FXW30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 18:29:26 -0400
In-Reply-To: <1307532194-13039-10-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> The pad values here are same as the default pad values updated in
> serial.c file.
> Avoid structure duplication and use default pads.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

This should be folded in with [03/12]

Kevin
