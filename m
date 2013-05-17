From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: change the device names in usb_bind_phy
Date: Fri, 17 May 2013 11:09:24 +0530
Message-ID: <5195C28C.40300@ti.com>
References: <1366697656-14315-1-git-send-email-kishon@ti.com>
 <51936946.3030507@iki.fi> <20130516155857.GV5600@atomide.com>
 <519503DA.5070303@iki.fi> <20130516162034.GX5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130516162034.GX5600@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com, Tomi Valkeinen <tomi.valkeinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 16 May 2013 09:50 PM, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130516 09:11]:
>> On 16/05/13 18:58, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130515 03:59]:
>>>
>>> Just checking.. Do you have CONFIG_OMAP_OCP2SCP=y in your .config? Sounds
>>> like the some transceivers should depend on that for omap4.
>>
>> Yes, I have OCP2SCP=y.
>
> Hmm well no idea beyond that then. Sounds like Kishon should check it.
>
>>>> The musb-hdrc id is wrong on overo also.
>>>
>>> Hmm has there been a fix posted for that?
>>
>> I couldn't find with a quick look. We debugged and discussed this on an irc
>> channel with Kishon, who said he'll send a patch. Changing the musb-hdrc ID
>> on overo fixed the issue, and it looks very similar to the error on 4430sdp.
>> The overo fix was just:

hmm.. I think using device name to bind the controller and the phy can 
no longer be used reliably. I think it's better to have something like 
what Grant suggested in my other patch series.. to have the phy 
reference into the host controllers platform_data structure. And for the 
phy reference I'll have label and id.

Does this makes sense to you?

Thanks
Kishon
