From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Mon, 15 Nov 2010 09:35:04 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C012B11@dbde02.ent.ti.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
 <AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755722Ab0KOEFW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Nov 2010 23:05:22 -0500
In-Reply-To: <AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

bryan.wu@canonical.com wrote:
> On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen

[snip]

>> 
>> For both panel power on and off some panels require some sleep times:
>> when powering on, the video interface has to be enabled for some time
>> before the panel can be enabled, and similarly when powering off the
>> video interface needs to be on for some time after the panel has been
>> disabled. 
>> 
> 
> Actually, in my previous version patches, I introduced
> .power_on_delay and .power_off_delay in panel_configs, which
> contains the sleep value for msleep(). But Archit told me
> this is not necessary, so I removed that.

I had asked you to remove it from omap_dss_device to a more
specific struct for the generic dpi driver :)

It should be in the 'panel_generic_dpi_data' struct now.

Regards,
Archit
