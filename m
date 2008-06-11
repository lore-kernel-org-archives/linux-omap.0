From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH] i2c: twl4030: warning: mixed declarations and code
Date: Wed, 11 Jun 2008 10:02:53 -0400
Message-ID: <a0580c510806110702m655cf96by6dbd9800ef48adf4@mail.gmail.com>
References: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com>
	 <a0580c510806110653p65b64857y8de6897489d60466@mail.gmail.com>
	 <20080611135502.GI20671@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:8412 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYFKOCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 10:02:54 -0400
Received: by py-out-1112.google.com with SMTP id p76so1414258pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 07:02:54 -0700 (PDT)
In-Reply-To: <20080611135502.GI20671@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Balbi,

On Wed, Jun 11, 2008 at 9:55 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> On Wed, Jun 11, 2008 at 09:53:45AM -0400, ext Eduardo Valentin wrote:
>> > -       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
>> >        u32 l;
>> > +       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
>>
>> To me you are just moving the place of this declaration.
>
> Yes, because ISO C99 forbids mixed declaraction and code. build
> tlw4030-usb and you'll see the warning. ;-)

Ok. I'd suggest changing the commit message to
i2c: twl4030: C99 warning: mixed declarations and code

But this is up to you :)

>
> --
>        - Balbi
>



-- 
Eduardo Bezerra Valentin
