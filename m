From: Rupesh Gujare <rupeshgujare@gmail.com>
Subject: Re: android-omap-2.6.29 for gumstix overo
Date: Fri, 17 Jul 2009 18:50:21 +0530
Message-ID: <d4060d560907170620o7a0da2c2i568e02103a0176ae@mail.gmail.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
	 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
	 <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5679BEA@dbde02.ent.ti.com>
	 <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f200.google.com ([209.85.212.200]:39928 "EHLO
	mail-vw0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933374AbZGQNUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 09:20:23 -0400
Received: by vwj38 with SMTP id 38so799300vwj.33
        for <linux-omap@vger.kernel.org>; Fri, 17 Jul 2009 06:20:21 -0700 (PDT)
In-Reply-To: <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

Hi All,
  Sometime back we tested android on overo. Most of stuff from
following link should work on it with little modifications in kernel.
http://labs.embinux.org/index.php/Android_For_OMAP3_with_Gstreamer_Inte=
gration

Regards,
Rupesh Gujare

On Fri, Jul 17, 2009 at 5:39 PM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
>
> Hi Vikram,
>
> On Jul 15, 2009, at 1:26 AM, Pandita, Vikram wrote:
>
>> All this is already available and integrated on android public git t=
ree.
>> This had DSS2 and PM.
>>
>> http://android.git.kernel.org/?p=3Dkernel/omap.git;a=3Dsummary
>> Head: android-omap-2.6.29
>> Validated on Zoom2.
>
> I'm taking a look at the android-omap-2.6.29 and trying to see if I c=
an get it to work for the overo.
>
> I just have a quick question, the board-zoom2.c file does not seem to=
 include an OMAP PM support, for example:
>
> #include <mach/omap-pm.h>
> #include "pm.h"
> #include "omap3-opp.h"
>
> I need a reference example of OMAP PM working for a TI OMAP3503 targe=
t.
>
> Best regards,
>
> Elvis
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
