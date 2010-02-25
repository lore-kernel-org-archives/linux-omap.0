From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6] OMAP UART: Add omap-serial driver support.
Date: Thu, 25 Feb 2010 10:54:56 -0800
Message-ID: <873a0pjgcf.fsf@deeprootsystems.com>
References: <52471.192.168.10.88.1266504626.squirrel@dbdmail.itg.ti.com>
	<87hbp6pjg2.fsf@deeprootsystems.com>
	<20100224185421.GR28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60591 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390Ab0BYSy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 13:54:59 -0500
Received: by pwj8 with SMTP id 8so5872429pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 10:54:59 -0800 (PST)
In-Reply-To: <20100224185421.GR28173@atomide.com> (Tony Lindgren's message of "Wed\, 24 Feb 2010 10\:54\:22 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100224 10:36]:
>> 
>> After that and Olof's comments, it should be submitted to linux-serial
>> and LKML.
>
> Also, it needs to be posted as a series with the related
> hwmod patches needed to actually test this driver with the
> mainline kernel.

I think this driver could be submitted upstream for review, even
without the platform support, as long as it's stated that the 
platform support is still missing and will merge via linux-omap.

The hwmod stuff is not yet ready for mainline.

Kevin
