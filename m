From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] omap: zoom3: add zoom3 board support
Date: Fri, 23 Oct 2009 16:17:08 -0500
Message-ID: <4AE21D54.2030109@ti.com>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com> <1256325806-14400-2-git-send-email-vikram.pandita@ti.com> <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>,<1256325806-14400-4-git-send-email-vikram.pandita@ti.com> <A24693684029E5489D1D202277BE89444B781BAA@dlee02.ent.ti.com>,<4AE2081E.7070501@ti.com> <A24693684029E5489D1D202277BE89444B781BAB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33345 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbZJWVRF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 17:17:05 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NLH9qx028421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 16:17:09 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9NLH8k2027867
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 16:17:08 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9NLH8Ri027321
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 16:17:08 -0500 (CDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444B781BAB@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre Rodriguez, Sergio Alberto had written, on 10/23/2009 03:07 PM, 
the following:
[...]
>> Linux-OMAP build allows for both boards to be defined at the same time..
>> so in theory you could have a single uImage. the strategy followed here
>> will fail it.. since the board file is the same one.. it could be made
>> to work though..
>>
> 
> Not with this approach :)
> 
> How about making board-zoom3.c separate from board-zoom2.c, and do a
> smarter way to share as much as possible?
> 
> To modularize, I'll suggest taking a look at RX51 board files. That way you can have
> board-zoom2.c, board-zoom3.c, with the modules shared accordingly in Makefile.
> 
> Camera is already doing that ;)
> 
> What do you think?
Ack.

-- 
Regards,
Nishanth Menon
