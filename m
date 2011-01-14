From: "Jan, Sebastien" <s-jan@ti.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 18:48:49 +0100
Message-ID: <AANLkTim2dv+cKDsDgPMQFWgEcN_p1Q1_R6HFh3=v44Xk@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com> <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
 <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com> <36befcf1947882da51ace32cbfb0b922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54028 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757498Ab1ANRwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 12:52:04 -0500
Received: by mail-ww0-f48.google.com with SMTP id 20so3193530wwd.17
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:52:02 -0800 (PST)
In-Reply-To: <36befcf1947882da51ace32cbfb0b922@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Hi Santosh,

On Fri, Jan 14, 2011 at 6:22 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>>
>> I just tested with the 2.6.37 mainline kernel and Bryan config, and
>> can reproduce the issue with CONFIG_SMP disabled.
> Can you try the patch I sent on the list as well ?

Bryan is currently testing your patch. I have a build running with
HIGHMEM deactivated.

I'll also make a try on blaze board. I do not expect any difference
here. Note that the only way to trigger this issue for me was to make
native compilation of a big component (like native kernel
compilation).
