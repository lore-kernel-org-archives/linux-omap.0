From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC] [PATCH 0/3] media: an attempt to refresh omap1_camera driver
Date: Fri, 1 Jul 2016 09:37:04 +0200
Message-ID: <991378b3-1cd8-afa3-81cc-f65a99d7274f@xs4all.nl>
References: <1466097694-8660-1-git-send-email-jmkrzyszt@gmail.com>
 <5763A114.2080309@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <5763A114.2080309@xs4all.nl>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/17/2016 09:04 AM, Hans Verkuil wrote:
> Hi Janusz,
> 
> On 06/16/2016 07:21 PM, Janusz Krzysztofik wrote:
>> As requested by media subsystem maintainers, here is an attempt to 
>> convert the omap1_camera driver to the vb2 framework. Also, conversion 
>> to the dmaengine framework, long awaited by ARM/OMAP maintainers, is 
>> done.
>>
>> Next, I'm going to approach removal of soc-camera dependency. Please 
>> let me know how much time I have for that, i.e., when the soc-camera
>> framework is going to be depreciated.
> 
> Well, it is already deprecated (i.e. new drivers cannot use it), but it won't
> be removed any time soon. There are still drivers depending on it, and some
> aren't easy to rewrite.
> 
> I have to say that it is totally unexpected to see that this omap1 driver is still
> used. In fact, we've already merged a patch that removed it for the upcoming
> 4.8 kernel. Based on this new development I'll revert that for the omap1
> driver.

Actually, I decided not to revert it. So it will be removed in 4.8. However, that
does not affect you. Just bring it back once it is in shape.

Regards,

	Hans

> 
> Out of curiosity: is supporting the Amstrad Delta something you do as a hobby
> or are there other reasons?
> 
> A final note: once you've managed to drop the soc-camera dependency you should
> run the v4l2-compliance test over the video node (https://git.linuxtv.org/v4l-utils.git/).
> 
> If that passes without failures, then this driver is in good shape and can be
> moved out of staging again.
> 
> Regards,
> 
> 	Hans
> 
>>
>> Thanks,
>> Janusz
>>
>>
>> Janusz Krzysztofik (3):
>>   staging: media: omap1: drop videobuf-dma-sg mode
>>   staging: media: omap1: convert to videobuf2
>>   staging: media: omap1: use dmaengine
>>
>>  drivers/staging/media/omap1/Kconfig              |   5 +-
>>  drivers/staging/media/omap1/omap1_camera.c       | 948 +++++------------------
>>  include/linux/platform_data/media/omap1_camera.h |   9 -
>>  3 files changed, 217 insertions(+), 745 deletions(-)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
