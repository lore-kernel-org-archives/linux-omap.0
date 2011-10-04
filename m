From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract regulator_init_data
Date: Tue, 04 Oct 2011 10:58:40 +0530
Message-ID: <4E8A9988.3080907@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-3-git-send-email-rnayak@ti.com> <20110927121003.GB4289@opensource.wolfsonmicro.com> <4E81E224.2070408@ti.com> <20110927150511.GM4289@opensource.wolfsonmicro.com> <4E854532.6080605@ti.com> <20110930102849.GA4195@opensource.wolfsonmicro.com> <20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com> <20110930121844.GI5366@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36188 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900Ab1JDF2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 01:28:48 -0400
Received: by mail-yx0-f169.google.com with SMTP id 19so164720yxi.14
        for <linux-omap@vger.kernel.org>; Mon, 03 Oct 2011 22:28:47 -0700 (PDT)
In-Reply-To: <20110930121844.GI5366@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 30 September 2011 05:48 PM, Mark Brown wrote:
> On Fri, Sep 30, 2011 at 04:39:02PM +0530, Rajendra Nayak wrote:
>
>> The "regulator-supplies" is used to specific the regulator *parent*.
>> Same as what was earlier passed by using the
>> "supply_regulator" field of regulator_init_data structure.
>> Grant wanted the bindings to support specifying multiple parents
>> and hence I was thinking of either a list of names *or*
>> a list of phandles to specify multiple parents to a regulator.
>
> So, as I'm fairly sure I said last time these are just standard
> supplies.  It just happens to be that the consumer is a regulator.  The
> fact that Linux chooses to have core framework handling for this is an
> implementation detail of Linux (and indeed many devices ignore this for
> their on board regulators).

Yes, the implementation details of linux is what is making me using
these bindings difficult, and maybe you can help me how I can work
around the framework. The binding themselves, I agree should not care
if the consumer is a device/IP or a regulator itself.

So here's my problem:

I use the <name-supply> = <&reg_phandle> binding to define
a device/IP using one/more regulators on one/more rails.

device mmc {
	...
	...
	vmmc-supply = <&vmmc>;
	vpll-supply = <&vpll>;
};

The parsing of the "vmmc-supply" or the "vpll-supply" property
happens only when a mmc drivers makes a call to
regulator_get() passing the supply-name as "vmmc" or "vpll".
For ex:
regulator_get(dev, "vmmc"); or regulator_get(dev, "vpll");

Its easy to just append the "-supply" to a "vmmc" or "vpll"
and derive a property name like "vmm-supply" or "vpll-supply".

Now lets take the case of a regulator as a consumer:

regulator vmmc {
	...
	...
	vin-supply = <&vin>;
};

Now I need to parse the "vin-supply" property during a
regulator_register(), so I could do a set_supply() and
create the parent/child relationship between a vin and
vmmc.
The problem is I don't know if the property in the regulator dt
node is called "vin-supply" or "vxyz-supply" and hence I
can parse the property based on a substring alone, which is
"-supply" because all I know is the property name is expected
to end with a "-supply".

I can always add a new of_find_property_substr() which finds
me property based on a substring value passed rather than the
exact property-name string.
However I don;t know if this is the best way to handle it.
Any thoughts?



