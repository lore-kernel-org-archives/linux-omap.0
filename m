From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/8] OMAP: omap_device: add usecounting
Date: Tue, 24 Nov 2009 10:13:03 -0800
Message-ID: <636c5030911241013s635437d4vc31b71f462d44b70@mail.gmail.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
	 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
	 <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
	 <alpine.DEB.2.00.0911180349590.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47967 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbZKXSM4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 13:12:56 -0500
Received: by pzk1 with SMTP id 1so4975192pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 10:13:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180349590.25515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Wed, Nov 18, 2009 at 2:51 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Kevin,
>
> On Tue, 17 Nov 2009, Kevin Hilman wrote:
>
>> Add use counters to omap_device to enable multiple potential users o=
f
>> an omap_device. =A0This is needed if ever there are multiple users o=
r
>> multiple instances of a driver with a single omap_device.
>>
>> Without usecounting, with multiple users, the first one to call idle
>> may forcibly idle the device while other users are still active.
>
> Could you please send along an example of the use case for this? =A0I=
 would
> prefer not to add usecounting at this layer unless it is absolutely
> necessary, since only one driver should be bound to a device at a tim=
e.

OK, after some more wrangling with the UART layer, I don't think I
will need this patch.

If an omap_device is bound to a single driver, the driver itself can
do the usecounting and will be more effecient when doing so.

Note however that this will prevent any direct replacement of
clk_enable/disable with omap_device_enable/disable since some drivers
are built on the assumption that the clk API does usecounting.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
