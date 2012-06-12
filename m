From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 1/2] arm/dts: OMAP2: Add support for OMAP2420 SDP
Date: Tue, 12 Jun 2012 11:32:25 -0500
Message-ID: <4FD76F19.5030808@ti.com>
References: <1339107066-10461-1-git-send-email-jon-hunter@ti.com> <1339107066-10461-2-git-send-email-jon-hunter@ti.com> <20120612072025.GG12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45076 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab2FLQca (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 12:32:30 -0400
In-Reply-To: <20120612072025.GG12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 06/12/2012 02:20 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120607 15:15]:
>> Simple DTS file for OMAP2420 SDP adding memory information to allow device-tree
>> testing on an OMAP2420 SDP.
>>
>> Verified that kernel boots with DT using a simple RAMDISK file-system on
>> OMAP2420 SDP.
> 
> I suspect this is the H4 board? If so, please rename it to H4 as it shares
> the "debug board" with H2 and H3 so in theory we may at some point have
> some common .dtsi for the debug board devices..

Yes, in fact I believe that 2420 SDP == H4 [1]. We appear to like
changing and chopping naming conventions at TI ;-)

I will update to H4 to be more consistent with the kernel naming.

Cheers
Jon

[1]
http://www.ti.com/general/docs/wtbu/wtbusplashcontent.tsp?templateId=6123&contentId=4750#omap2
