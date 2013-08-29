From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 06/15] OMAPDSS: remove all old panel drivers
Date: Thu, 29 Aug 2013 19:38:10 +0530
Message-ID: <521F55CA.8050003@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com> <1377783120-14001-7-git-send-email-tomi.valkeinen@ti.com> <521F53F0.4030203@ti.com> <521F555C.8090802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51623 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab3H2OI7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 10:08:59 -0400
In-Reply-To: <521F555C.8090802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 29 August 2013 07:36 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 29/08/13 17:00, Archit Taneja wrote:
>> On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
>>> The board files now use the new panel drivers, making the old panel
>>> drivers obsolete.
>>>
>>> Remove the old panel drivers, Kconfig and Makefile entries, and the
>>> panels' platform data structs.
>>
>> Can we convert the picodlp driver to the new panel driver model, and
>> report it as broken for now?
>
> (please cut your quotes a bit, you just included some thousands of lines
> of code there =).

Oops, sure, will try to remember.

>
> We could, but I'm not sure what would be the point. The new picodlp
> would be (more or less) totally new driver, so we would still end up
> removing the old driver. We can as well add it later if we manage to get
> it working.

Okay. Let's do that then.

Archit

