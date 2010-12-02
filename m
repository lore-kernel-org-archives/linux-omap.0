From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Thu, 2 Dec 2010 16:33:39 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F0A4AFD@dbde02.ent.ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
	 <1291217886.10133.171.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
	 <1291282030.778.9.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035F0A4A5C@dbde02.ent.ti.com>
	 <1291285184.778.17.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035F0A4AB8@dbde02.ent.ti.com>
 <1291287633.778.24.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab0LBLDt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 06:03:49 -0500
In-Reply-To: <1291287633.778.24.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> On Thu, 2010-12-02 at 16:00 +0530, ext Taneja, Archit wrote:
>> Hi,
> 
>>> Unfortunately the panel driver for N800 has not been ported to DSS2.
>> 
>> I can possibly try with a 2430sdp, but I don't see the "omapdss"
>> platform_device board-2430dsp.c. Are you aware of any omap2 setup which I
>> can use to test? 
> 
> Hmm, I guess no OMAP2 board has been ported to use DSS2. I
> have 2430SDP, but unfortunately it's been broken for long time now.
> 
> I believe 2430SDP would be easy to port, but as it's been
> quite a while since I ran DSS2 on OMAP2, it may well be that
> there are some DSS bugs with OMAP2.
> 
> If you want, you can try to get 2430sdp running, and at some
> point it would be very good to have at least one OMAP2 board
> with DSS2 running.
> But perhaps it's not so important right now.

Okay, so I'll push a new patch set with your suggestions soon.

Regards,
Archit

> 
>  Tomi
> 
> Ps. I'll be on vacation tomorrow and next week.