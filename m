From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 2/2] of: allow for boolean flags to have value
Date: Thu, 05 Feb 2015 19:16:47 +0100
Message-ID: <2914350.UYQI23DbG0@wuerfel>
References: <1423159266-25561-1-git-send-email-balbi@ti.com> <1423159266-25561-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60993 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbBESQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 13:16:57 -0500
In-Reply-To: <1423159266-25561-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thursday 05 February 2015 12:01:06 Felipe Balbi wrote:
> +       /*
> +        * if property doesn't have a value, or prop->length == 0 and
> +        * we overflow, treat it as simple value-less flag.
> +        */
> +       if (rc == -ENODATA || rc == -EOVERFLOW)
> +               return true;
> +       if (WARN(rc < 0, "failed to read '%s' value -> %d\n",
> +                               propname, rc))
> +               return false;
> 

I think there are drivers today that use of_property_read_bool()
to check for the presence of a property that is not already empty.
If the property starts with a zero cell, that would break here.

	Arnd
