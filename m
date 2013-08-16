From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
	ip revisions
Date: Fri, 16 Aug 2013 21:11:30 +0530
Message-ID: <520E482A.1070504@ti.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com>
	<1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
	<520E341D.4080206@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <520E341D.4080206-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 8/16/2013 7:45 PM, Benoit Cousson wrote:
> Hi Gururaja,
> 
> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
>> The syntax of compatible property in DT is to mention the Most specific
>> match to most generic match.
>>
>> Since AM335x is the platform with latest IP revision, add it 1st in
>> the device id table.
> 
> I don't understand why? The order should not matter at all.

Yes, it should not. We are trying to work around a bug in the kernel
where the compatible order is not honored (instead the order in
of_match[] array matters). There were patches being discussed to fix this.

> 
> I've tried to follow the thread you had with Mark on the v2, but AFAIK,
> you've never answered to his latest question.
> 
> Moreover, checking the differences between the Davinci and the am3352
> RTC IP, I would not claim that both are compatible.
> 
> Sure you can use the am3352 with the Davinci driver, but you will lose
> the wakeup functionality without even being notify about that.

When the kernel is fixed for the bug pointed out above, this should not
happen with properly defined compatible property.

> 
> For my point of view, compatible mean that the HW will still be fully
> functional with both versions of the driver, which is not the case here.

I do not think that's the interpretation of compatible. Its goes from
most specific to most generic per the ePAPR spec. That in itself says
that 100% functionality is not expected if you don't find a match for
the more specific property.

> 
> am3352 DTS must use the ti,am3352-rtc to have the expected behavior.

Yes, that's what patch 2/2 does.

> Using the ti,da830-rtc version will not make the board working as
> expected. So we cannot claim the compatibility.

Ideally, the DT file was *always* written as

	compatible = "ti,am3352-rtc", "ti,da830-rtc";

even when there was no kernel support for AM3352 RTC.

That way, there is no need to update the .dts[i] file. As kernel gains
functionality, more features (like rtc wake) is available to users.
Otherwise they get plain RTC functionality - but at least they get
something instead of no RTC.

Thanks,
Sekhar
