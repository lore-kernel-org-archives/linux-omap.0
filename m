From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 27 Jan 2010 09:49:01 -0800
Message-ID: <87y6jjwi9e.fsf@deeprootsystems.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
	<20100127172526.GB23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:53522 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0A0RtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 12:49:07 -0500
Received: by fxm7 with SMTP id 7so2904578fxm.28
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 09:49:06 -0800 (PST)
In-Reply-To: <20100127172526.GB23505@atomide.com> (Tony Lindgren's message of "Wed\, 27 Jan 2010 09\:25\:26 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

[...]

>
> Do you have the board related patches somewhere so people can
> actually test this driver?
>

Tony, the board/platform related patches are in my pm-wip/uart branch
as part of the conversion of that code to hwmod/omap_device.

This patch on top of that branch is working fine, at least for
basic console.

Kevin
