From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V4 1/5] ARM: dts: OMAP: Add timer nodes
Date: Wed, 24 Oct 2012 17:29:29 -0500
Message-ID: <50886BC9.6040800@ti.com>
References: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
 <1350658744-13509-2-git-send-email-jon-hunter@ti.com>
 <50880C19.2090508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50880C19.2090508-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 10/24/2012 10:41 AM, Benoit Cousson wrote:
> Hi Jon,
> 
> On 10/19/2012 04:59 PM, Jon Hunter wrote:
>> Add the 12 GP timers nodes present in OMAP2.
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>> Add the 7 GP timers nodes present in AM33xx.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>> Vaibhav's original nodes adding information on which timers support a PWM
>> output.
>>
>> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> 
> I updated the patch to remove the interrupt-parent from the DTS nodes and the documentation, as discussed on the list in the context of OMAP5 DTS for GPIO.
> 
> If you are OK with that version, I'll push it to Tony along with the others DTS patches.

Thanks! Yes fine with me. I have boot tested on OMAP2420, OMAP3430 and
OMAP4430.

Tested-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>

Cheers
Jon
