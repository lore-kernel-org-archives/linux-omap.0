From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 2/2 V6] OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
Date: Mon, 26 Apr 2010 16:50:54 +0200
Message-ID: <8B4456C7-B8B1-47C6-A4D4-89BDB31B740E@student.utwente.nl>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E304C@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E7394044E1EBEB2@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:57567 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0DZOvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 10:51:20 -0400
Received: by ewy20 with SMTP id 20so3753257ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 07:51:18 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E1EBEB2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 26 apr 2010, om 15:27 heeft Hiremath, Vaibhav het volgende geschreven:

>> 
>> +CONFIG_FRAMEBUFFER_CONSOLE=y
> [Hiremath, Vaibhav] Are you sure you want FRAMEBUFFER_CONSOLE option to be enabled here? This actually brings a dark cursor on display which is annoying. Atleast I have seen multiple request in the past to remove this option from field.

Can't you setterm that cursor off? I have fbcon enabled and don't see that cursor. And please trim your replies, it is getting annoying to pinpoint replies between a gazillion unrelated lines of patch.

regards,

Koen