From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Mon, 20 Dec 2010 15:34:16 +0800
Message-ID: <AANLkTikwRS7CmooumKk7t8p53f3H2xQcHh-sZ=VuXft+@mail.gmail.com>
References: <201012201546.12319.manningc2@actrix.gen.nz>
	<AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
	<AANLkTimcAs0X6B9j9DpbAg1K7aAT7JAyXoOyRZYCeNHG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56161 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab0LTHeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 02:34:20 -0500
Received: by wwa36 with SMTP id 36so2654766wwa.1
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 23:34:18 -0800 (PST)
In-Reply-To: <AANLkTimcAs0X6B9j9DpbAg1K7aAT7JAyXoOyRZYCeNHG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
Cc: Charles Manning <manningc2@actrix.gen.nz>, linux-omap@vger.kernel.org

Hi,

2010/12/20 Abraham Arce <abraham.arce.moreno@gmail.com>:
> Hi,
>
> On Sun, Dec 19, 2010 at 9:04 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> In fact, the transition is not friendly indeed for a user. I don't know why
>> the transition is introduced, for what purpose? Who can give a explanation?
>>
>
> Patch itself has one explanation, kernel commit is
> b612633b5928077441b979471869753bfa93d41a
>
> http://www.spinics.net/lists/linux-serial/msg02788.html

The commit does not explain the cause of renaming ttyS to ttyO, does it?

thanks,
-- 
Lei Ming
