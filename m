From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Mon, 15 Nov 2010 13:33:02 +0800
Message-ID: <AANLkTikuRUaVRLLSHzgV_neaEwA4=xary=HQz=ax-Ytm@mail.gmail.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
	<AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC356087034C012B11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0KOFdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 00:33:04 -0500
Received: by qwi4 with SMTP id 4so230919qwi.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Nov 2010 21:33:02 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034C012B11@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>

On Mon, Nov 15, 2010 at 12:05 PM, Taneja, Archit <archit@ti.com> wrote:
> Hi,
>
> bryan.wu@canonical.com wrote:
>> On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen
>
> [snip]
>
>>>
>>> For both panel power on and off some panels require some sleep times:
>>> when powering on, the video interface has to be enabled for some time
>>> before the panel can be enabled, and similarly when powering off the
>>> video interface needs to be on for some time after the panel has been
>>> disabled.
>>>
>>
>> Actually, in my previous version patches, I introduced
>> .power_on_delay and .power_off_delay in panel_configs, which
>> contains the sleep value for msleep(). But Archit told me
>> this is not necessary, so I removed that.
>
> I had asked you to remove it from omap_dss_device to a more
> specific struct for the generic dpi driver :)
>

Yeah, no problem.

> It should be in the 'panel_generic_dpi_data' struct now.
>

I think the delay value is related to panel, which can be found in
sharp_ls and sharp_lq drivers. So it might be in the "panel_configs"
struct?

Thanks,
-Bryan
