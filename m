From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Beagle PM hangs
Date: Sat, 31 Jan 2009 13:18:32 +0200
Message-ID: <1233400712.14037.34.camel@localhost>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	 <87zlhbqtrv.fsf@deeprootsystems.com>	<87skn3qq6x.fsf@deeprootsystems.com>
	 <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
	 <13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
	 <212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
	 <87y6wsh100.fsf@deeprootsystems.com>
	 <13B9B4C6EF24D648824FF11BE89671620376E9A684@dlee02.ent.ti.com>
	 <87pri4gz1m.fsf@deeprootsystems.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41812 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZAaLVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 06:21:07 -0500
In-Reply-To: <87pri4gz1m.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Sat, 2009-01-31 at 00:21 +0100, ext Kevin Hilman wrote:

> CPUfreq policy is just as easily set in the kernel at init time.  Then
> the default would be set right, and the rootfs would be left to change
> it if desired.

But in general the situation is more complex and knowledge about the
packaging and its thermal model is needed.

Note that with packaging i refer to both the omap package (does it use
stacked memory or not, is it a memory combo, etc) and the _device_
package.

Not getting errors is not a good indication that the system is really
operating in a safe mode; the device might be stable all the time but
its life be more than halved.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki

