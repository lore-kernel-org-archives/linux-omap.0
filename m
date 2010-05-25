From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Mon, 24 May 2010 17:07:49 -0700
Message-ID: <87r5l0u9m2.fsf@deeprootsystems.com>
References: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
	<87y6fcerz1.fsf@deeprootsystems.com>
	<17f301cafb40$2bc91e80$LocalHost@wipblrx0100947A>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47938 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab0EYAHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 20:07:52 -0400
Received: by pxi18 with SMTP id 18so1683331pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 17:07:51 -0700 (PDT)
In-Reply-To: <17f301cafb40$2bc91e80$LocalHost@wipblrx0100947A> (Govindraj R.'s message of "Mon\, 24 May 2010 18\:23\:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>, saaguirre@ti.com
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This happening because we are missing these patches:
>  
> https://patchwork.kernel.org/patch/84748/
> https://patchwork.kernel.org/patch/84749/
> https://patchwork.kernel.org/patch/84755/
> https://patchwork.kernel.org/patch/84750/
>  
> Not part of LO yet.
>
> But we need these patches for uart4 support for 3630.

Ah, OK.  I thought these had been merged already.

Looks like these need to be refreshed/resubmitted for l-o.  Sergio?

Kevin
