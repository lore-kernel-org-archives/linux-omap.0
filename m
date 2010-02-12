From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: compilation error
Date: Fri, 12 Feb 2010 18:44:11 +0100
Message-ID: <6D8C14D7-65BF-4335-B7B8-424DBA80E563@dominion.thruhere.net>
References: <4ad3b6301002120213t21332383xb288befe7c821772@mail.gmail.com> <4B754770.3080703@mlbassoc.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:34640 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0BLRoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 12:44:17 -0500
Received: by fxm20 with SMTP id 20so2585996fxm.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 09:44:16 -0800 (PST)
In-Reply-To: <4B754770.3080703@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Niamathullah sharief <omapsha@gmail.com>, linux-omap@vger.kernel.org


Op 12 feb 2010, om 13:20 heeft Gary Thomas het volgende geschreven:

> On 02/12/2010 03:13 AM, Niamathullah sharief wrote:
>> Hello,
>> can anyone tell me while compilaing "dbus-1.2.20" i am getting the
>> folllowing error
>> "checking for XML_ParserCreate_MM in -lexpat... no
>> configure: error: Could not find expat.h, check config.log for failed attempts"
>> what is wrong?what i should install?i installed libexpat also. still i
>> get the same error. please help me
> 
> As previously mentioned, this list is for discussion of the
> Linux kernel on OMAP, not user/support questions.  You should
> take them to a more appropriate list.
> 
> What higher level of software are you trying to run on your
> OMAP board (distribution, if you want to call it that)?
> Some examples might be:
> * OpenEmbedded, Poky, etc

I must point out that OpenEmbedded is not a distro, it's a tool to make distros (e.g. like 'make', 'deb-build', 'portage', etc).

A distro that works well on OMAP3, built by OE, is angstrom.

regards,

Koen