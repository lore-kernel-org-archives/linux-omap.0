From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v4 2/7] OMAP: DSS2: Represent DISPC register defines
 with channel as parameter
Date: Tue, 16 Nov 2010 09:55:59 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C101E49@dbde02.ent.ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-3-git-send-email-archit@ti.com>
 <1289834238.2668.41.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53596 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757299Ab0KPE0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 23:26:07 -0500
In-Reply-To: <1289834238.2668.41.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Mon, 2010-11-08 at 13:24 +0100, ext Archit Taneja wrote:
>> From: Sumit Semwal <sumit.semwal@ti.com>
>> 
>> Introduce new enum members for LCD2 Channel and corresponding Overlay
>> Manager. 
>> 
>> Represent some of the DISPC register defines with channel as a
>> parameter to differentiate between LCD, DIGIT and LCD2 channels.
>> Replace the existing reads/writes to these registers in this new way.
>> 
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> Signed-off-by: Mukund Mittal <mmittal@ti.com>
>> Signed-off-by: Samreen <samreen@ti.com>
> 
> <snip>
> 
>> @@ -1843,9 +1847,9 @@ static void
> dispc_enable_digit_out(bool enable)
>> bool dispc_is_channel_enabled(enum omap_channel channel)  {
>>         if (channel == OMAP_DSS_CHANNEL_LCD)
>> -               return !!REG_GET(DISPC_CONTROL, 0, 0);
>> +               return !!REG_GET(DISPC_CONTROL(channel), 0, 0);
>>         else if (channel == OMAP_DSS_CHANNEL_DIGIT)
>> -               return !!REG_GET(DISPC_CONTROL, 1, 1);
>> +               return !!REG_GET(DISPC_CONTROL(channel), 1, 1);         else
>>                 BUG();
>>  }
> 
> I don't think this is good.
> 
> Looking at the code here, it looks like we're accessing
> different DISPC_CONTROL registers for LCD and DIGIT out. But we're not.
> 
> For some registers it's good to have DISPC_XXX(ch) style,
> when the registers are accessed identically for different
> channels. Then you can just modify the same bits in
> DISPC_REG(ch) register, and you don't have to mind what the channel actually
> is. 
> 
> But this is not the case in the function above.
> 
> The DISPC_CONTROL(ch) is defined as:
> DISPC_REG(ch != 2 ? 0x0040 : 0x0238)
> 
> I don't think this is actually right. DISPC_CONTROL is not a
> register defined per channel. The register at 0x40 contains
> bits for both channels 0 and 1. Perhaps leave DISPC_CONTROL
> as it was, and add DISPC_CONTROL2, because the registers are
> not used similarly for all channels. Or you can come up with
> some other solution, but using channel as argument for the macro doesn't look
> right. 

Yes, this holds for DISPC_CONTROL and DISPC_CONFIG registers, I didn't
think it would be wrong if 2 channels point to the same register field.

But apart from that, there are some bits in these registers which are
not specific to any channel and doing something like this would be misleading,

For setting fifiomerge:
REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 14, 14);

Since the above bit is not specific to LCD channel.

I'll keep these 2 registers the way they are.

Thanks,

Archit