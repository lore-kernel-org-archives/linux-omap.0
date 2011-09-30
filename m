From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract regulator_init_data
Date: Fri, 30 Sep 2011 16:39:02 +0530
Message-ID: <4E85A34E.9070203@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-3-git-send-email-rnayak@ti.com> <20110927121003.GB4289@opensource.wolfsonmicro.com> <4E81E224.2070408@ti.com> <20110927150511.GM4289@opensource.wolfsonmicro.com> <4E854532.6080605@ti.com> <20110930102849.GA4195@opensource.wolfsonmicro.com> <20110930104820.GE2085@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:37184 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758300Ab1I3LJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 07:09:11 -0400
Received: by mail-yw0-f53.google.com with SMTP id 2so1964492ywt.26
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 04:09:10 -0700 (PDT)
In-Reply-To: <20110930104820.GE2085@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 30 September 2011 04:18 PM, Mark Brown wrote:
> On Fri, Sep 30, 2011 at 11:28:49AM +0100, Mark Brown wrote:
>> On Fri, Sep 30, 2011 at 09:57:30AM +0530, Rajendra Nayak wrote:
>
>>>>> +  init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>>> +                                          "regulator-supplies", NULL);
>
>>> Mark, I still seem to be a little confused with this one as to why
>>> we would need a phandle *and* a supply-name to reference a parent
>>> regulator/supply.
>>> The phandle would point to a regulator dt node and that node internally
>>> would have just one name associated with it.
>
>> To repeat: the supply name is for the consumer.  It is needed so that
>> the consumer can tell which supply is provided by which regulator.
>> Almost all devices have more than one supply and if the device does
>> anything more complicated than just turning on all the supplies when the
>> device is active it's going to need to figure out which supply is which.
>
> Hang on, I now have no idea what this is supposed to be doing.  Later on
> in the series you had examples in your commit logs with perfectly
> sensible bindings for supplies:
>
>                  vmmc-supply =<&regulator1>;
>                  vpll-supply =<&regulator1>;
>
> which have both a unique name and a direct reference to the supplying
> regulator.  What are these "regulator-supplies" properties supposed to
> be?

:-), yes, I was confused for a while as well after reading your response.

The "regulator-supplies" is used to specific the regulator *parent*.
Same as what was earlier passed by using the
"supply_regulator" field of regulator_init_data structure.
Grant wanted the bindings to support specifying multiple parents
and hence I was thinking of either a list of names *or*
a list of phandles to specify multiple parents to a regulator.


