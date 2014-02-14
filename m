From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
Date: Fri, 14 Feb 2014 08:58:19 +0100
Message-ID: <52FDCC9B.2050608@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
 <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
 <52FCDA29.90605@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52FCDA29.90605@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/13/2014 03:43 PM, Nishanth Menon wrote:
> On 02/13/2014 04:25 AM, Florian Vaussard wrote:
>> Update the compatible string for Overo/Tobi to reflect the latest
>> changes.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> index 34dc40c..af9b4a0 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> @@ -91,7 +91,7 @@ Boards:
>>    compatible = "ti,omap3-beagle", "ti,omap3"
>>  
>>  - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
>> -  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
>> +  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
> omap3-overo-storm-tobi.dts is not covered here, so, I wonder as the
> number of boards supported keep increasing, is'nt it better we drop
> the board information from omap.txt?
> 

I am not opposed to this. We will just have checkpatch warnings due to
undocumented compatible strings.

Regards,
Florian
