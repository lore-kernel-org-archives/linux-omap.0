From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [RFC v3][PATCH 0/4] OMAP: DSS2: Overlay Manager LCD2 support in
 DISPC
Date: Wed, 20 Oct 2010 09:26:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BB01466@dbde02.ent.ti.com>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
 <1287493790.2216.26.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53727 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab0JTD4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 23:56:35 -0400
In-Reply-To: <1287493790.2216.26.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Tue, 2010-10-05 at 13:55 +0200, ext Archit Taneja wrote:
>> This patch series which incorporates changes in DSS2 to enable
>> omap_dss_device instances to use the new Overlay Manager LCD2 in DISPC.
>> 
>> On OMAP4, we have a new DISPC channel for Overlay Manager LCD2. This
>> channel's video port is a source port for RFBI, DSI2 and DPI. The
>> Primary channel's video port is connected to RFBI and DSI1.
>> 
>> There is a set of regsiters for LCD2 channel similar to the existing
>> LCD channel, like DISPC_CONTROL2, DISPC_DIVISOR2, DISPC_CONFIG2 and so on.
>> 
>> In order to decide which LCD Overlay Manager to configure(LCD/LCD2),
>> there is a need for the omap_dss_device instances to tell the
>> interface drivers(DSI, DPI, RFBI etc) which LCD channel they want to
>> connect to, so that the corresponding registers get configured.
>> Therefore, a new enum omap_channel member is introduced to omap_dss_device.
>> 
>> This design was made keeping in mind the possible addition of more
>> Overlay Managers in future OMAPs, this code is also backward
>> compatible with OMAP3 as omap_dss_device instances in OMAP3 will stick
>> only with OMAP_DSS_CHANNEL_LCD.
>> 
>> This will apply over the set of dss_feature framework patches:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34768.html
> 
> The patchset makes dispc API changes in patch 2, but doesn't
> change any of the code that uses that API. This means that
> the kernel doesn't compile after applying patch 2.
> 
> The kernel has to be compilable and working after each patch, so that is not
> acceptable. 
> 
> Fixing that in easy way would mean squashing the later
> patches together with patch 2, but that would result in a
> huge patch, and patch 2 is already very big. Thus I'd suggest
> doing the changes in smaller bits.
> 
> You could first add the register definitions, and make the
> changes in dispc.c to keep everything working. After that you
> could change the dispc functions, one by one or in small
> groups (depending on the amount of changes), and add the
> channel argument and adjusting the code using those functions in the same
> time. 
> 
> This would solve the problem of keeping the kernel working,
> and would make the patches much more readable.

Thanks, will take care of this.

Archit
