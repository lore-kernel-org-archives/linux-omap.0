From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
Date: Fri, 14 Feb 2014 02:14:58 -0600
Message-ID: <52FDD082.9090006@ti.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch> <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch> <52FCDA29.90605@ti.com> <52FDCC9B.2050608@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbaBNIP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 03:15:27 -0500
In-Reply-To: <52FDCC9B.2050608@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 02/14/2014 01:58 AM, Florian Vaussard wrote:
> Hi,
> 
> On 02/13/2014 03:43 PM, Nishanth Menon wrote:
>> On 02/13/2014 04:25 AM, Florian Vaussard wrote:
>>> Update the compatible string for Overo/Tobi to reflect the latest
>>> changes.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> index 34dc40c..af9b4a0 100644
>>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> @@ -91,7 +91,7 @@ Boards:
>>>    compatible = "ti,omap3-beagle", "ti,omap3"
>>>  
>>>  - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
>>> -  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
>>> +  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
>> omap3-overo-storm-tobi.dts is not covered here, so, I wonder as the
>> number of boards supported keep increasing, is'nt it better we drop
>> the board information from omap.txt?
>>
> 
> I am not opposed to this. We will just have checkpatch warnings due to
> undocumented compatible strings.

Aaah, I seemed to have missed bff5da43 commit, thanks for pointing me
at it - unrelated to this patch, I think the board cleanups is a
little overdue :(

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
