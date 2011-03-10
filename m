From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
Date: Thu, 10 Mar 2011 10:03:09 -0800
Message-ID: <87oc5idfaa.fsf@ti.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1103091943550.15132@utopia.booyaka.com>
	<AANLkTikN=1TLGoqLE4OBNdq4DDHAimGURA9ejy7TOZm7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:60313 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963Ab1CJSDP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 13:03:15 -0500
Received: by mail-pz0-f49.google.com with SMTP id 5so134258pzk.8
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 10:03:14 -0800 (PST)
In-Reply-To: <AANLkTikN=1TLGoqLE4OBNdq4DDHAimGURA9ejy7TOZm7@mail.gmail.com>
	(Jean Pihet's message of "Thu, 10 Mar 2011 11:03:37 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]
>> Please create two different functions,
>> omap_device_set_max_dev_wakeup_lat() and
>> omap_device_set_min_bus_tput(). =C2=A0Documentation/CodingStyle chap=
ter 6.
>>

> It has been agreed (in weekly calls) to have two functions at the OMA=
P
> PM level but only one function with a class parameter at the
> omap_device level. This allows easier maintenance and clean-up later.
> Kevin, is that corrcet?

Yes, that is my preference (but Paul is the maintainer of these layers,
so he has the final say.)  What I would like to see is a more generic
API at the omap_device level which can easily be extended to handle new
constraints (by adding a new 'class'), without having to grow the API
each time.

That being said, you can still create the two functions that Paul
mentioned above and just have the generic function call those based on
class.

The only question then is which interface the drivers will eventually
use.  I much prefer keeping the driver interface to a simple set of add
& remove constraint functions where the type is determined by class:

Today we have:

 - max wakeup latency
 - min bus througput

but eventually we may also want

 - min frequency
 - max frequency (thermal)
 - etc.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
