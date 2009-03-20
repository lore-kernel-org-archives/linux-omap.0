From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Subject: Re: strange usb errors
Date: Fri, 20 Mar 2009 19:34:13 +0100
Message-ID: <ac9c93b10903201134r4079725fp3c3a27eca0879e63@mail.gmail.com>
References: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57924 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbZCTSeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 14:34:16 -0400
Received: by fxm2 with SMTP id 2so1020922fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 11:34:13 -0700 (PDT)
In-Reply-To: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

one more issue, same hw/sw;

If I connect my webcam (pwc driver) through the hub on the usb host port I get:
pwc: isoc_init() submit_urb 0 failed with error -28

On the otg port (again through a hub) there are some aretefacts (as
reported before)

directly connecting the cam to the usb host port does not work (guess
it is a 1.1 device which is not supported on the beagle host port).

Frans.
