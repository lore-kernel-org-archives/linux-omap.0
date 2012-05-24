From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] OMAP: mailbox initial device tree support
Date: Thu, 24 May 2012 17:44:15 +0200
Message-ID: <4FBE574F.6070408@ti.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org> <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "patches@linaro.org" <patches@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 5/2/2012 7:42 AM, Bedia, Vaibhav wrote:
> Hi Omar,
>
> On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
>> To allow mailbox driver to function with device tree.
>>
>> Tested in OMAP4 and OMAP3. OMAP2 untested.
>
> I think the mailbox code needs a cleanup similar to what you
> had proposed earlier [1] before the device tree support is added.
>
> We probably need to decide whether the number of mailbox sub-modules
> should be part of hwmod attribute or come from device tree. IMO the
> static allocation of the mailboxes is better suited in the device-tree
> data.

Ideally yes, but that assumes we are supporting only DT boot method, 
which is still not the case today.

That being said, the driver might still be able to leverage DT if 
available already.


This can be done later as well.

Omar,
That's up to you.

Regards,
Benoit
