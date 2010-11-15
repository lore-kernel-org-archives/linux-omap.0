From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Mon, 15 Nov 2010 14:13:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C101A63@dbde02.ent.ti.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
	<AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC356087034C012B11@dbde02.ent.ti.com>
 <AANLkTikuRUaVRLLSHzgV_neaEwA4=xary=HQz=ax-Ytm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab0KOIni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 03:43:38 -0500
In-Reply-To: <AANLkTikuRUaVRLLSHzgV_neaEwA4=xary=HQz=ax-Ytm@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

Bryan Wu wrote:
> On Mon, Nov 15, 2010 at 12:05 PM, Taneja, Archit
> <archit@ti.com> wrote:
>> Hi,
>> 
>> bryan.wu@canonical.com wrote:
>>> On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen
>> 
>> [snip]
>> 
>>>> 
>>>> For both panel power on and off some panels require some sleep times:
>>>> when powering on, the video interface has to be enabled for some
>>>> time before the panel can be enabled, and similarly when powering
>>>> off the video interface needs to be on for some time after the panel has
>>>> been disabled. 
>>>> 
>>> 
>>> Actually, in my previous version patches, I introduced
>>> .power_on_delay and .power_off_delay in panel_configs, which contains
>>> the sleep value for msleep(). But Archit told me this is not
>>> necessary, so I removed that.
>> 
>> I had asked you to remove it from omap_dss_device to a more specific
>> struct for the generic dpi driver :)
>> 
> 
> Yeah, no problem.
> 
>> It should be in the 'panel_generic_dpi_data' struct now.
>> 
> 
> I think the delay value is related to panel, which can be
> found in sharp_ls and sharp_lq drivers. So it might be in the "panel_configs"
> struct?

Yes, I think that makes more sense.

Thanks,
Archit