From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: omap: driver registration cleanups
Date: Thu, 17 May 2012 08:27:24 -0400
Message-ID: <871umj56xf.fsf@laptop.org>
References: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
	<CANrkHUaajRTd3D3QU7pfTRN5cv9QaqYcryOs4YNSYHq-kBkYVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34551 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab2EQM1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 08:27:25 -0400
In-Reply-To: <CANrkHUaajRTd3D3QU7pfTRN5cv9QaqYcryOs4YNSYHq-kBkYVw@mail.gmail.com>
	(T. Krishnamoorthy's message of "Thu, 10 May 2012 20:24:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Thu, May 10 2012, T Krishnamoorthy, Balaji wrote:
> On Tue, May 8, 2012 at 5:05 PM, Venkatraman S <svenkatr@ti.com> wrote=
:
>> Cleanups for the legacy omap mmc driver to remove clutter and
>> make it well behaved as module.
>>
>> Venkatraman S (3):
>> =C2=A0mmc: omap: convert to per instance workqueue
>> =C2=A0mmc: omap: make it behave well as module
>> =C2=A0mmc: omap: convert to module_platform_driver
>
> Looks good to me, So
> Acked-by: Balaji T K <balajitk@ti.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
