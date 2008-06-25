From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a
	module
Date: Wed, 25 Jun 2008 15:11:19 +0300
Message-ID: <1214395879.24418.40.camel@mort>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	 <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
	 <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
	 <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32709 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbYFYMPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 08:15:09 -0400
In-Reply-To: <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

On Wed, 2008-06-25 at 07:03 -0500, ext Felipe Balbi wrote:

> And like you said, if the defconfig is all modular (or all built-in)
> the user/manufacturer/hacker can always change it later. Although
> I defend that Reference Boards' defconfigs should be as modular
> as possible.

I totally agree: furthermore testing power features is damn easier if we
can bisect the modules and zero on the offending driver.

And on top of that, having modules allows to makes it simpler to address
in one go different boards and subarchitectures.

The SDP is to many of us just the mean to develop sw for the real HW.
Modules don't harm SDP only users but help those involved in product
creation.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
