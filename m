From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Fri, 21 May 2010 16:42:21 -0700
Message-ID: <878w7cg6ua.fsf@deeprootsystems.com>
References: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:58583 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792Ab0EUXm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 19:42:27 -0400
Received: by pzk6 with SMTP id 6so685369pzk.1
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 16:42:27 -0700 (PDT)
In-Reply-To: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 20 May 2010 19\:08\:24 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Introduce UART4 hwmod data for OMAP3630
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Looks good, except omap4_hwmod was not added to the master list of
hwmods to initialize.

Fixed up locally.

Kevin
