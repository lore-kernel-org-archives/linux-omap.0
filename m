From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] staging: drm/omap: fix missing include on omap_crtc
Date: Thu, 29 Nov 2012 22:48:15 +0100
Message-ID: <CAFqH_512yjfuPJ1OWbihMwDYcDLn+Ok9ytZes9Qnn8NB2E9zBA@mail.gmail.com>
References: <1354107300-26619-1-git-send-email-eballetbo@gmail.com>
	<50B7CFEC.6040109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57860 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab2K2VsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 16:48:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so7930439pad.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 13:48:15 -0800 (PST)
In-Reply-To: <50B7CFEC.6040109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob@ti.com>
Cc: gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

Hi Rob,

2012/11/29 Rob Clark <rob@ti.com>:
> On 11/28/2012 06:55 AM, Enric Balletbo i Serra wrote:
>>
>> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>>
>> This fixes following error:
>>
>> | ...
>> | CC [M]  drivers/staging/omapdrm/omap_crtc.o
>> | .../omapdrm/omap_crtc.c:22:22: fatal error: drm_mode.h: No such file or
>> directory
>> | ...
>
>
> fwiw, I have this patch in my local tree that is fixing the same issue:
>
> https://patchwork.kernel.org/patch/1588461/
>

Thanks, I didn't see this patch in linux-omap ML and others ML that
I'm subscribed. Please skip this patch.

>
> and I think I've seen at least one other patch for the same thing..   it
> would be nice to at least get one version of this fix in 3.7..
>

Completely agree.

Best regards,
   Enric

> BR,
> -R
>
>
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>> ---
>>   drivers/staging/omapdrm/omap_crtc.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/omapdrm/omap_crtc.c
>> b/drivers/staging/omapdrm/omap_crtc.c
>> index 732f2ad..1d54fe9 100644
>> --- a/drivers/staging/omapdrm/omap_crtc.c
>> +++ b/drivers/staging/omapdrm/omap_crtc.c
>> @@ -17,9 +17,9 @@
>>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>   -#include "omap_drv.h"
>> +#include <drm/drm_mode.h>
>>   -#include "drm_mode.h"
>> +#include "omap_drv.h"
>>   #include "drm_crtc.h"
>>   #include "drm_crtc_helper.h"
>>
>
>
