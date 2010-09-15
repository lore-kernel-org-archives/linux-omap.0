From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v3 2/2] OMAP: DSS2: Use dss_features framework on DSS2
 code
Date: Wed, 15 Sep 2010 17:04:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703117E9E54@dbde02.ent.ti.com>
References: <1284355810-20899-1-git-send-email-archit@ti.com>
	 <1284355810-20899-3-git-send-email-archit@ti.com>
 <1284539461.2522.117.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58725 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0IOLef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 07:34:35 -0400
In-Reply-To: <1284539461.2522.117.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was reworking some patches, I saw 2 functions in manager.c:

dss_mgr_wait_for_go() and dss_mgr_wait_for_go_ovl() both
define the var "enum omap_channel channel;" but don't use it.

Is there any reason this is done, or is it just stray code?

Tomi Valkeinen wrote:
> On Mon, 2010-09-13 at 07:30 +0200, ext Archit Taneja wrote:
>> Calls init functions of dss_features during dss_probe, and the
>> following features are made omapxxxx independent:
>>   - number of managers, overlays
>>   - supported color modes for each overlay
>>   - supported displays for each manager
>>   - global aplha, and restriction of global alpha for video1 pipeline
>>   - The register field ranges : FIRHINC, FIRVINC, FIFOHIGHTHRESHOLD
>>     FIFOLOWTHRESHOLD and FIFOSIZE
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>  arch/arm/plat-omap/include/plat/display.h |   31 ----------------
>>  drivers/video/omap2/dss/core.c            |    3 ++
>>  drivers/video/omap2/dss/dispc.c           |   56
>>  ++++++++++++++++------------- drivers/video/omap2/dss/manager.c         |  
>>  33 ++++++++--------- drivers/video/omap2/dss/overlay.c         |   24
>>  +++++------- 5 files changed, 60 insertions(+), 87 deletions(-)
> 
> snip
> 
>>  static void _dispc_setup_global_alpha(enum omap_plane plane, u8
>> global_alpha)  { -
>> -       BUG_ON(plane == OMAP_DSS_VIDEO1);
>> -
>> -       if (cpu_is_omap24xx())
>> +       if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
>>                 return;
>> 
>> +       BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
>> +                       plane == OMAP_DSS_VIDEO1);
>> +
>>         if (plane == OMAP_DSS_GFX)
>>                 REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
>>         else if (plane == OMAP_DSS_VIDEO2) @@ -949,17 +950,14 @@
>> static void dispc_read_plane_fifo_sizes(void)
>> 
> DISPC_VID_FIFO_SIZE_STATUS(1) };
>>         u32 size;
>>         int plane;
>> +       u8 size1, size2;
> 
> You have a bit inconsistent naming with these. The function
> is defined as accepting start and end, here you use size1 and size2, below
> you have foo1 and foo2.
> 
> Size is not a good name, as it's not size at all. Perhaps
> foo_start and foo_end (or just start and end if there's only
> one feat being used)? Or foo_msb and foo_lsb (as in most/least significant
> bit)? 
> 
> Otherwise looks good.
> 
>  Tomi