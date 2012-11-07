From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2] usb: musb: dsps: dt binding - add resources, example
Date: Wed, 7 Nov 2012 12:03:09 +0100
Message-ID: <509A3FED.1050304@ti.com>
References: <1352210166-7253-1-git-send-email-afzal@ti.com> <20121106164445.GE3993@arwen.pp.htv.fi> <509941D1.6020405@ti.com> <20121106182207.GB5252@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121106182207.GB5252@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Afzal Mohammed <afzal@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, Daniel Mack <zonque@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 11/06/2012 07:22 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 06, 2012 at 05:58:57PM +0100, Benoit Cousson wrote:
>> On 11/06/2012 05:44 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Nov 06, 2012 at 07:26:06PM +0530, Afzal Mohammed wrote:
>>>> OMAP2+ family of devices are now obtaining resources via DT, earlier
>>>> it was obtained from hwmod. Update binding document accrodingly, while
>>>> at it add example.
>>>>
>>>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>>>
>>> this looks fine to me:
>>>
>>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>>>
>>> Benoit, do you take Documentation patches too ?
>>
>> Well, ideally it should go with the driver change. But if this is a
>> simple change related to generic attribute I can take it.
> 
> ok, cool. Please take this via your tree.

Done. I've just applied it in my for_3.8/dts_part2 branch.

Regards,
Benoit
