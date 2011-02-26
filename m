From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/1] power_supply: twl4030_charger modification
Date: Sat, 26 Feb 2011 20:10:17 +0200
Message-ID: <AANLkTik_N0Kk7putk+mb__S7NJxCYHSrxCH=DofduGpX@mail.gmail.com>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
	<20110225121234.GI4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36784 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1BZSKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Feb 2011 13:10:18 -0500
Received: by vws12 with SMTP id 12so2189726vws.19
        for <linux-omap@vger.kernel.org>; Sat, 26 Feb 2011 10:10:18 -0800 (PST)
In-Reply-To: <20110225121234.GI4190@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Heikki Krogerus <heikki.krogerus@nokia.com>, linux-omap@vger.kernel.org, cbouatmailru@gmail.com

On Fri, Feb 25, 2011 at 2:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Feb 25, 2011 at 01:56:35PM +0200, Heikki Krogerus wrote:
>> Hi guys,
>>
>> Grazvydas, I don't have hardware to test this with. If this is OK to
>> you, could you test it?

Sure, replied to your patch.

>> Felipe, was the idea that you take this with the atomic notifier
>> support for otg patches? I guess this is how it needs to be done in
>> order to keep things bisectable, right? Or does this simply go to
>> Anton?
>
> We can't change patches anymore :-( So as long as it goes on the merge
> window, we should be ok, hopefully.

Talking about notifiers, do we have away to find the amount of current
host can provide yet? I haven't followed USB development closely
lately.
