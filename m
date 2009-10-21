From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] omapfb: Wrong test on unsigned?
Date: Wed, 21 Oct 2009 17:43:44 +0200
Message-ID: <4ADF2C30.3030401@gmail.com>
References: <4AD8BA2F.9090307@gmail.com> <A24693684029E5489D1D202277BE89444CEFEAF5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36068 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZJUPdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 11:33:35 -0400
Received: by ewy3 with SMTP id 3so6170057ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2009 08:33:39 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444CEFEAF5@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Imre Deak <imre.deak@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

regno is unsigned so the test didn't work. If regno
can't be used return an error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
>> Is this correct? please review.
>>
>> diff --git a/drivers/video/omap/omapfb_main.c 
>> b/drivers/video/omap/omapfb_main.c
>> index 0d0c8c8..cc7dd93 100644
>> --- a/drivers/video/omap/omapfb_main.c
>> +++ b/drivers/video/omap/omapfb_main.c
>> @@ -286,7 +286,7 @@ static int _setcolreg(struct fb_info 
>> *info, u_int regno, u_int red, u_int green,
>>  		if (r != 0)
>>  			break;
>>  
>> -		if (regno < 0) {
>> +		if ((int)regno < 0) {
> 
> Hmm...
> 
> Isn't regno unsigned integer from the start?

yes

> 2 things here:
> 
> - regno will never be negative.
> - Casting won't make a difference in the meaning., it'll make a negative only when:
> 
> 	regno > ((2^32) / 2)
> 
> Which doesn't make any sense IMHO.

I think it is strange that _setcolreg() accepts a regno that is invalid,
ignores it and just returns as if all was OK. If you agree then you may
like the patch below.

> Regards,
> Sergio

Thanks,

Roel

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 0d0c8c8..4da94d0 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -285,12 +285,6 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 	case OMAPFB_COLOR_RGB444:
 		if (r != 0)
 			break;
-
-		if (regno < 0) {
-			r = -EINVAL;
-			break;
-		}
-
 		if (regno < 16) {
 			u16 pal;
 			pal = ((red >> (16 - var->red.length)) <<
@@ -299,6 +293,8 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 					var->green.offset) |
 			      (blue >> (16 - var->blue.length));
 			((u32 *)(info->pseudo_palette))[regno] = pal;
+		} else {
+			r = -EINVAL;
 		}
 		break;
 	default:
