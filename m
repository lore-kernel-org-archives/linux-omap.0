From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
 (try #8)
Date: Mon, 22 Nov 2010 17:00:18 +0800
Message-ID: <AANLkTik7Ny+eEPTziqwW0CeV9YO4JHVweQ-Dwi-HBF+w@mail.gmail.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290003526.26444.30.camel@tubuntu>
	<AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
	<1290071469.3431.4.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56222 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0KVJAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 04:00:19 -0500
Received: by qyk12 with SMTP id 12so24725qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 01:00:18 -0800 (PST)
In-Reply-To: <1290071469.3431.4.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Thu, Nov 18, 2010 at 5:11 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Thu, 2010-11-18 at 10:14 +0800, ext Bryan Wu wrote:
>> On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen
>
>> > Are you also interested in solving the backlight issue? =3D)
>>
>> Yeah, can I start with
>> drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to mo=
ve
>> the blacklight code to drivers/video/blacklight/ and let sharp_ls to
>> use panel-generic-dpi.c driver.
>
> Yes, I think that's a good solution for the panels which have a separ=
ate
> backlight (ie. all these "dummy" panels"). However, I'm not sure how
> that would work for panels with more integrated backlight, for exampl=
e
> Taal. But we don't need to worry about that right now.
>

As I'm working on the sharp-ls panel driver, I just find the backlight
code is almost dummy functions which will call
dssdev->set_backlight().
How about create platform driver for sharp-ls backlight driver? We
pass those dssdev data from platform data struct.

Thanks a lot,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
