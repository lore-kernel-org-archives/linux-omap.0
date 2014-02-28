From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [pandaboard] OTG port not working (updated)
Date: Fri, 28 Feb 2014 21:30:39 +0100
Message-ID: <5310F1EF.2040108@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:59546 "EHLO
	smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbaB1UiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 15:38:20 -0500
Received: from [192.168.0.34] (ip-84-119-26-155.unity-media.net [84.119.26.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.math.uni-bielefeld.de (Postfix) with ESMTPSA id 74B3F60106
	for <linux-omap@vger.kernel.org>; Fri, 28 Feb 2014 21:30:42 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I just updated: https://bugzilla.kernel.org/show_bug.cgi?id=64771

Kernel is now 3.13-rc4, plus some patches (also the USB ones by Roger
Quadros). Still no working host mode on the port.

Maybe some of the TI USB guys can a look?

With best wishes,
Tobias
