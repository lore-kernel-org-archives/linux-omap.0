From: Suman Anna <s-anna@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Thu, 11 Jul 2013 19:40:47 -0500
Message-ID: <51DF508F.3050703@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi> <20130710161158.GA19716@arwen.pp.htv.fi> <20130711063209.GZ5523@atomide.com> <51DE8215.5060306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54357 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab3GLAq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 20:46:57 -0400
In-Reply-To: <51DE8215.5060306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On 07/11/2013 04:59 AM, Grygorii Strashko wrote:
> Hi,
> 
> On 07/11/2013 09:32 AM, Tony Lindgren wrote:
>> * Felipe Balbi <balbi@ti.com> [130710 09:18]:
>>>
>>> On Wed, Jul 10, 2013 at 07:07:04PM +0300, Felipe Balbi wrote:
>>>> how about something like below ? It makes omap_device/hwmod and
>>>> pm_runtime agree on the initial state of the device and will prevent
>>>> ->runtime_resume() from being called on first pm_runtime_get*() done
>>>> during probe.
>>>>
>>>> This is similar to what PCI bus does (if you look at pci_pm_init()).
>>>>
>>>> commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
>>>> Author: Felipe Balbi <balbi@ti.com>
>>>> Date:   Wed Jul 10 18:50:16 2013 +0300
>>>>
>>>>      arm: omap2plus: unidle devices which are about to probe
>>>>
>>>>      in order to make HWMOD and pm_runtime agree on the
>>>>      initial state of the device, we will unidle the device
>>>>      and call pm_runtime_set_active() to tell pm_runtime
>>>>      that the device is really active.
> Don't think that it's good idea (
> I've checked some driver's and think this patch will enable some devices
> unpredictably:
> - hwspinlock
> - mailbox
> - iommu
> - ipu
> All above devices need to be enabled on demand only (no
> pm_runtime_get*() calls in probe). More over, some of them have very
> specific enabling sequence - like ipu).
> 
> May be Summan can say more on that.

Indeed, this is a problem for any of the slave processor devices.
mailbox and iommu would be slaves to the remoteproc and the drivers have
a specific sequence of bringing up a processor. The current
hwmod/omap_device code is such that these devices will be left in reset
and the driver code use the omap_device_(de)assert_hardreset API
together with omap_device_enable code to bring up the devices. The
remoteproc driver also needs to assert the resets (there are other
problems associated with using omap_device_idle for remoteproc and
iommu) for bringing up the devices after a suspend sequence. hwspinlock
and mailbox may get away since they are in CORE domain, but definitely
an issue for iommu and remoteproc. I would think that this would also
affect other compute devices like IVAHD, ISS, SGX.

regards
Suman

> 
>>>>
>>>>      By the time driver's probe() is reached, a call to
>>>>      pm_runtime_get_sync() will not cause driver's
>>>>      ->runtime_resume() method to be called at first, only
>>>>      after a successful ->runtime_suspend().
>>>>
>>>>      Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>
>>> btw, this is RFC, haven't tested at all.
>>
>> Yes it does not compile, then removing the extra ; at the end
>> of the functions, it oopses with a NULL pointer exception.
>>
>> Regards,
>>
>> Tony
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

