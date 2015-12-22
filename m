From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] OMAPDSS: fix omapfb build error due missing feat
 functions declaration
Date: Tue, 22 Dec 2015 09:02:02 -0300
Message-ID: <56793BBA.80003@osg.samsung.com>
References: <1450722384-4606-1-git-send-email-javier@osg.samsung.com>
 <567900BD.6070907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <567900BD.6070907@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Tomi,

On 12/22/2015 04:50 AM, Tomi Valkeinen wrote:
> Hi Javier,
> 
> On 21/12/15 20:26, Javier Martinez Canillas wrote:
>> The omapfb is failing to build in -next due missing declarations for
>> dss_feat_get_supported_displays() and dss_feat_get_supported_outputs():
>>
>>  CC [M]  drivers/video/fbdev/omap2//omapfb/dss/dss.o
>> drivers/video/fbdev/omap2//omapfb/dss/dss.c: In function 'dss_save_context':
>> drivers/video/fbdev/omap2//omapfb/dss/dss.c:144:2: error: implicit declaration of function 'dss_feat_get_supported_displays' [-Werror=implicit-function-declaration]
>>
>> Add the declaration for these functions in the dss_features.h header
>> file to fix this compile error.
>>
>> Also, remove the functions export since are not used outside the driver.
> 
> Thanks!
>

You are welcome.
 
> Yep, I messed that up. I thought I had tested it, but apparently I only
> tested the final for-next only for omapdrm, which does compile and work.
>

Yes, that's what I thought.
 
> omapdss.h is the the only file still shared between omapdrm and omapfb
> after the copy-omapdss-series (I'll work on omapdss.h later), and of
> course there was a change to omapdss.h which broke the build.
> 
> So I rebased the copy-omapdss-series on top of the rest of the omapdss
> patches, and updated the "omapfb: copy omapdss & displays for omapfb" to
> make a fresh copy of omapdss for omapfb. I think it's better to update
> the series, rather than applying fixes for already confusing series.
>

I completely agree, maintaining bisectability is important. As I mentioned
in my last email, I just posted in case you couldn't rework your branches
for whatever reason.
 
> I've pushed new version to my for-next branch.
>

Great, thanks!

>  Tomi
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
