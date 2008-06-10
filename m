From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] radio-tea5761: Update driver
Date: Tue, 10 Jun 2008 13:42:55 -0400
Message-ID: <a0580c510806101042g7698c811v668387e1dbc34531@mail.gmail.com>
References: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-2-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-3-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-4-git-send-email-edubezval@gmail.com>
	 <20080609234028.GC4962@kedavra.cpe.vivax.com.br>
	 <a0580c510806091814g246a1553n7e78f8a857d978f8@mail.gmail.com>
	 <20080610020746.GF4962@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:45689 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbYFJRm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 13:42:57 -0400
Received: by py-out-1112.google.com with SMTP id p76so1283909pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 10:42:55 -0700 (PDT)
In-Reply-To: <20080610020746.GF4962@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Balbi,

On Mon, Jun 9, 2008 at 10:07 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Jun 09, 2008 at 09:14:21PM -0400, Eduardo Valentin wrote:
>> If I understood correctly what you said, the same comment I said
>> before also applies here.
>> Eventhough it prints that the probe
>> failed, this way I sent it says: The probe failed and "The driver
>> registration failed". More easy
>> to debug the code when in a error situation.
>
> But if probe fails, driver registration failed. The same comment Jean
> Delvare gave me when I was sending some isp1301 patches upstream, so
> later on, when this driver goes to mailine, it'll probably, if Jean
> happens to see this one, get commented on this point as well.
>
> If you look at drivers/i2c/chips/*.c you'll see that only in two cases
> they are printing error if i2c_add_driver() fails and those are really
> necessary cases (check those drivers).
>
> But anyway, if you think it's really necessary.
>

Ok. I've just resent the whole series with this message removed. :)

> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>



-- 
Eduardo Bezerra Valentin
