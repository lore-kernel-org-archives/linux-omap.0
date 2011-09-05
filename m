From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Support for Innolux AT070TN83
Date: Mon, 05 Sep 2011 10:25:06 +0200
Message-ID: <4E648762.4050804@corscience.de>
References: <1314859332.1933.4.camel@deskari>  <1314882308-25915-1-git-send-email-weber@corscience.de> <1314950284.3374.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59223 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1IEIZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 04:25:26 -0400
In-Reply-To: <1314950284.3374.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Am 02.09.2011 09:58, schrieb Tomi Valkeinen:
> On Thu, 2011-09-01 at 15:05 +0200, Thomas Weber wrote:
>> Add support for Innolux AT070TN83, a 7 inch LCD
>> with RGB-Interface and touch panel to panel-generic-dpi.
>>
>> Tested with Devkit8000.
>>
>> Signed-off-by: Thomas Weber <weber@corscience.de>
>> ---
>>  drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
>>  1 files changed, 25 insertions(+), 0 deletions(-)
> Thanks, these look fine to me.
>
> The subject suggests there are 3 patches, but I presume that's wrong?
>
>  Tomi
>
>
>
You are right, I had an additional patch during format-patch.

Thomas
