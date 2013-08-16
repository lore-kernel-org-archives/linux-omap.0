From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/2] omap4/twl6030: typical connection to omap4 as
 a separate dtsi file
Date: Fri, 16 Aug 2013 15:17:06 +0200
Message-ID: <520E2652.4090103@baylibre.com>
References: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com> <520B8B45.1010300@baylibre.com> <CAB=otbTUk68CLmgQsEoefMMFTAnZCAMbZa-yiYmn1b3F1X8BiQ@mail.gmail.com> <CAHooxd7Sg8B-MM38F2ce=vR5ftO6ye2byrXH1-iFous=_AvTLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:48137 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3HPNRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 09:17:09 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so1638817wes.30
        for <linux-omap@vger.kernel.org>; Fri, 16 Aug 2013 06:17:08 -0700 (PDT)
In-Reply-To: <CAHooxd7Sg8B-MM38F2ce=vR5ftO6ye2byrXH1-iFous=_AvTLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uri Yosef <uri.y@variscite.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi Uri,

On 16/08/2013 14:30, Uri Yosef wrote:
> Hi,
>
> I am on vacation until Aug 25th, I will test it when I back.

OK, but it will be too late for this merge window. I'll drop it for 3.12 
then.

Thanks,
Benoit

>
> Regards,
> Uri Yosef
>
>
> On Fri, Aug 16, 2013 at 3:04 PM, Ruslan Bilovol <ruslan.bilovol@ti.com
> <mailto:ruslan.bilovol@ti.com>> wrote:
>
>     Hi Benoit,
>
>     On Wed, Aug 14, 2013 <tel:2013> at 4:51 PM, Benoit Cousson
>     <bcousson@baylibre.com <mailto:bcousson@baylibre.com>> wrote:
>      > Hi Ruslan,
>      >
>      > On 14/08/2013 10:35, Ruslan Bilovol wrote:
>      >>
>      >> Hello,
>      >>
>      >> There is no functional changes between v1 and v2 - just
>      >> added the patch for omap4-var-som - Uri Yosef confirmed
>      >> this board have the same connection of OMAP4<->TWL6030 as
>      >> SDP4430 board
>      >
>      >
>      > The series looks good to me, but it will be good to have a test
>     for Panda
>      > and Variscite boards before merging it.
>
>     Okay, so I just verified this patch series on PandaBoard ES2. Should I
>     resubmit this series with
>     fixed commit message?
>     However I cannot verify the patch for Variscite board because I do not
>     own any such board so
>     you can drop that patch. But maybe Uri Yosef can verify it. Uri?
>
>      >
>      > Regards,
>      > Benoit
>
>     --
>     Best regards,
>     Ruslan Bilvol
>
>

