From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] omap: i2c: Add calls for pinctrl state select
Date: Tue, 28 Apr 2015 08:11:29 -0500
Message-ID: <553F8701.4000501@ti.com>
References: <1429693667-28942-1-git-send-email-pascal.huerst@gmail.com> <55383D9A.4020302@ti.com> <553F696A.8060408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965446AbbD1NLh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Apr 2015 09:11:37 -0400
In-Reply-To: <553F696A.8060408@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pascal Huerst <pascal.huerst@gmail.com>, Nishanth Menon <nm@ti.com>, wsa@the-dreams.de
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

On 04/28/2015 06:05 AM, Pascal Huerst wrote:
[...]
> On 23.04.2015 02:32, Nishanth Menon wrote:

[...]
>> Would you think adding relevant documentation in
>> Documentation/devicetree/bindings/i2c/i2c-omap.txt might be good as
>> well? I mean, folks should know looking at dt documentation that this
>> bus driver does indeed support this option..
> 
> I'm not sure about that. Actually this is all handled by the pinctrl
> subsystem, so I would guess that documentation belongs there, since in:
> 
> Documentation/devicetree/bindings/i2c/i2c-at91.txt
> Documentation/devicetree/bindings/i2c/i2c-nomadik.txt
> 
> is no documentation about that as well. But there is documentation in:
> 
> Documentation/pinctrl.txt
> 
> right? Otherwise, I would say we should add documentation for all
> devices, so it is consistent.

that is probably good since drivers may or maynot support the sleep
configuration.


-- 
Regards,
Nishanth Menon
