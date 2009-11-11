From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9
 accelerometer
Date: Thu, 12 Nov 2009 02:02:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB36@dbde02.ent.ti.com>
References: <1257971179-28225-1-git-send-email-chudson@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812AbZKKUdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 15:33:01 -0500
In-Reply-To: <1257971179-28225-1-git-send-email-chudson@kionix.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "chudson@kionix.com" <chudson@kionix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Chris

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>chudson@kionix.com
>Sent: Wednesday, November 11, 2009 2:26 PM
>To: linux-omap@vger.kernel.org
>Cc: linux-input@vger.kernel.org; dmitry.torokhov@gmail.com; Chris Hudson
>Subject: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9 accelerometer
>
>From: Chris Hudson <chudson@kionix.com>
>
>This is a request for comments regarding adding driver support for the Kionix
>KXTE9 digital tri-axis accelerometer.  This part features built-in tilt
>position (orientation), wake-up and back-to-sleep algorithms, which can trigger
>a user-configurable physical interrupt.  The driver uses i2c for device
>communication, a misc node for IOCTLs, and input nodes for reporting
>acceleration data and interrupt status information.  Moved to
>drivers/input/misc after discussion on linux-omap mailing list.

Any way to test these features of accelerometer with your set of 3 patches applied?

Say with a busybox filesystem or poky?

>
>Changes in this version:
<snip>
