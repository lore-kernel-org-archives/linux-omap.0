From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
	pendown_gpio
Date: Fri, 4 Feb 2011 20:41:22 +0530
Message-ID: <AANLkTi=23s6jxGFVM9vUr3XopgPnSyfie2Ywj-PcKHSF@mail.gmail.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
	<20110203165405.GB12802@core.coreip.homeip.net>
	<20110203171953.GA13997@core.coreip.homeip.net>
	<20110204133250.GB2070@m-desktop>
	<20110204140847.GA3178@pengutronix.de>
	<20110204141618.GE2070@m-desktop> <4D4C116D.4080408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D4C116D.4080408@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, gadiyar@ti.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, balbi@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, charu@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 4, 2011 at 8:17 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
>
> On 02/04/11 16:16, G, Manjunath Kondaiah wrote:
>
>> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
>>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>>>>>> On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>>>>>>> The ads7846 driver requests a gpio but does not currently
>>>>>>> configure it explicitly as an input. Use gpio_request_one
>>>>>>> to request and configure it at one shot.
>>>>>>>
>>>>>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>>>>>> Cc: Dmitry Torokhov <dtor@mail.ru>
>>>>>> Will apply this one, the other one is a bit messy IMO, will have to
>>>>>> think about it.
>>>>>>
>>>>> Something like below should do I think.
>>>> Patch looks good but it applies only on top of previous patch:
>>>> https://patchwork.kernel.org/patch/529941/
>>>>
>>>> Why to have two patches for this fix?
>>> http://www.spinics.net/lists/linux-omap/msg45167.html
>> My point here is:
>> 1. The first patch only replaces gpio_request with gpio_request_one
>> 2. Rest of the things are handled in 2nd patch posted by dmitry
>>
>> What is harm in merging both the patches? I don't think it affects
>> readability.
>
> Because the changes introduced by the patches are from different nature.
> As stated in the link above, one is a functional change (gpio setup change)
> and second is fixing the imbalance in request - free calls.
> The impact is not readability, but bad bisect-ability.

  Dmitry's patch fixes both the problems(request/free and direction)
  in a single patch itself.Now there is no need of merging any patches.
  Just that Dmitry's patch need to be rebased over the top of HEAD. (Currently,
  its on top of my patch series).
>
>
> --
> Regards,
> Igor.
>
>
