From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Fri, 6 Sep 2019 23:02:28 +0300
Message-ID: <e2b75368-df70-b6c9-e019-61610859f146@ti.com>
References: <20190830121816.30034-2-t-kristo@ti.com>
 <20190906103558.17694-1-t-kristo@ti.com>
 <CAL_JsqLHTsEz6RJSi3rZ9AKyTBc00abyAxqwG8B9zAqL6cnv+w@mail.gmail.com>
 <20190906153658.GB52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190906153658.GB52127@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 06/09/2019 18:36, Tony Lindgren wrote:
> * Rob Herring <robh+dt@kernel.org> [190906 12:57]:
>> On Fri, Sep 6, 2019 at 11:36 AM Tero Kristo <t-kristo@ti.com> wrote:
>>>
>>> Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
>>> of these will act as a power domain controller and potentially as a reset
>>> provider.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>> v4:
>>> - renamed nodes as power-controller
>>> - added documentation about hierarchy
>>>
>>>   .../devicetree/bindings/arm/omap/prm-inst.txt | 31 +++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Looks good to me too:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> 

I may need to re-spin slightly new version of this. Stephen has some 
comments on the clock driver side I am depending on, he does not like 
the hard link between reset + clocks, so I may need to ditch the 
"clocks" property from this one also.

I'll see next week which direction I need to go.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
