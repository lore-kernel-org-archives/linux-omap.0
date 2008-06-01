From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Booting 2.6.25 on the OMAP5912OSK
Date: Sun, 01 Jun 2008 16:18:48 -0500
Message-ID: <856bb0d8d44339bd5dc8809833503dac@felipebalbi.com>
References: <4842D6FB.2050508@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [209.62.36.12] ([209.62.36.12]:33840 "EHLO
	serv01.siteground211.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752211AbYFAVUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jun 2008 17:20:39 -0400
In-Reply-To: <4842D6FB.2050508@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: linux-omap@vger.kernel.org

Hi,

On Sun, 01 Jun 2008 13:06:03 -0400, Philip Balister <philip@balister.org>
wrote:
> i2c_omap i2c_omap.1: Transmit overflow
> tps65010: power off button

Sounds like a bug in our i2c-omap.c

Tony do you know about any issues with i2c-omap.c after
highspeed i2c was introduced ?

This could be a regression, I remember seeing this on
some tests I was doing with twl4030 but they seemed
to vanish. Looks like I missed something. I'll try
to reproduce my bug with twl4030 and after that dig a
bit on i2c driver and i2c omap trms (ugh).

Anyways, if you could enable all debugging in i2c and
get more info when it happens, that would be great ;-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com


