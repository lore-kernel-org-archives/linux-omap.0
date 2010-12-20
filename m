From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Mon, 20 Dec 2010 12:21:14 +0100
Message-ID: <D3AD867F-8EB8-484A-9FC6-0882974E491E@dominion.thruhere.net>
References: <201012201546.12319.manningc2@actrix.gen.nz> <AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com> <AANLkTimcAs0X6B9j9DpbAg1K7aAT7JAyXoOyRZYCeNHG@mail.gmail.com> <AANLkTikwRS7CmooumKk7t8p53f3H2xQcHh-sZ=VuXft+@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48159 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab0LTLVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 06:21:20 -0500
Received: by wwa36 with SMTP id 36so2815661wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 03:21:17 -0800 (PST)
In-Reply-To: <AANLkTikwRS7CmooumKk7t8p53f3H2xQcHh-sZ=VuXft+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Abraham Arce <abraham.arce.moreno@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>, linux-omap@vger.kernel.org


Op 20 dec 2010, om 08:34 heeft Ming Lei het volgende geschreven:

> Hi,
> 
> 2010/12/20 Abraham Arce <abraham.arce.moreno@gmail.com>:
>> Hi,
>> 
>> On Sun, Dec 19, 2010 at 9:04 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>>> In fact, the transition is not friendly indeed for a user. I don't know why
>>> the transition is introduced, for what purpose? Who can give a explanation?
>>> 
>> 
>> Patch itself has one explanation, kernel commit is
>> b612633b5928077441b979471869753bfa93d41a
>> 
>> http://www.spinics.net/lists/linux-serial/msg02788.html
> 
> The commit does not explain the cause of renaming ttyS to ttyO, does it?

It does, ttyS* is reserved for 8250, nearly all ARM platforms have their own name (ttySAC, ttySA, etc). I'm surprised omap got away with this for so long.
I'm not saying the change is a pain, I'm just saying I went through this years ago for strongarm.

regards,

Koen