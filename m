From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: getnstimeofday() and suspend
Date: Fri, 15 Aug 2008 09:33:13 +0000
Message-ID: <1218792793.28834.33.camel@localhost>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
	 <20080813140016.GE27446@atomide.com>
	 <B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com>
	 <B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49987 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYHOJgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 05:36:47 -0400
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Fri, 2008-08-15 at 12:32 +0300, ext Tero.Kristo@nokia.com wrote:

> This behavior of the getnstimeofday() is breaking pm-debug and the
> serial console wakeup hack if we use suspend. Enabling RTC module seems
> to fix some of the issues in some cases, but we are going to lose timer
> accuracy (RTC accuracy is only 1 second.)

What about using the RTC for getting the base time and the 32kHz for the
extended granularity?

So one would use the RTC as ususal and then calculate the (less than 1s)
offset.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
