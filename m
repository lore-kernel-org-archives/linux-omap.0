From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: Add a reg-names property to name reg entries
Date: Wed, 26 Oct 2011 05:57:34 +0200
Message-ID: <FD4B90D7-4B26-42C2-8CF9-7AA9971BCBEB@kernel.crashing.org>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111025082632.GJ4429@atomide.com>
	<440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
	<4EA6BC54.7030007@ti.com>
	<BC60AF8F-C329-44B9-BEC9-EA5821725E1B@kernel.crashing.org>
	<4EA6DF88.2080704@ti.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4EA6DF88.2080704@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>>>> What problem does any of this solve?  The device binding for the
>>>> "mcasp" device will have to describe the possible "reg-names", and
>>>> what those mean; but the binding already has to describe its "reg"
>>>> property anyway.
>>>
>>> What this solve is the ability to use the
>>> platform_get_resource_byname directly to retrieve the proper
>>> register base address.
>>
>> You do not have to put it in the device tree for that, the device
>> driver can implement this itself if it cares.
>
> ???
>
> The driver is the user of that name, so it has to be populated  
> before into the resource during device creation.

It can be as simple as

#define FOO_REG_INDEX 0
#define BAR_REG_INDEX 1

but you can use C strings if you want to.

>>> The binding is just a text description that the driver will not be
>>> able to use directly. It will have to get the resource using an
>>> abstract index.
>>
>> Your reg-names are abstract identifiers just as well.
>
> This is the name used in the HW documentation.

So?  The device binding will still have to list them, for exact spelling
and register block size etc.

> Ordering them to get a number is purely arbitrary.

Ordering them is required, "reg" is an array.  It also matters which
entry is the first entry (for the unit address).

> That's why using the name will allow the driver to get the resource  
> the way it is represented in the documentation and thus avoid some  
> intermediate number.

You use an intermediate string instead, and add code and binding to
translate that to that same number.

>>> It thus removes a level of indirection that is error prone and
>>> useless most of the time.
>>
>> It *adds* a level of indirection.  I doubt it helps prevent errors
>> either, but who knows.
>
> Well, if that does not bring anything to you, you can just not use it.

I could, if you did this for your device binding only, but it seems
you are adding this as a generic thing.  I am very much against that.
The device tree should describe the hardware; it shouldn't describe
the description of the hardware, that's what bindings are for.


Segher
