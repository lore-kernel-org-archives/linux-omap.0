From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 5 Dec 2012 16:33:48 -0600
Message-ID: <50BFCBCC.6030706@ti.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
 <1354734571-10774-6-git-send-email-zonque@gmail.com>
 <20121205222232.67B2B3E0E22@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121205222232.67B2B3E0E22@localhost>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, avinashphilip-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant,

On 12/05/2012 04:22 PM, Grant Likely wrote:
> On Wed,  5 Dec 2012 20:09:31 +0100, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instantiated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
>>
>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  77 ++++++++++
>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
>>  arch/arm/mach-omap2/gpmc.c                         | 171 ++++++++++++++++++++-
>>  3 files changed, 323 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> new file mode 100644
>> index 0000000..7d2a645
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> @@ -0,0 +1,77 @@
>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>> +
>> +The actual devices are instantiated from the child nodes of a GPMC node.
>> +
>> +Required properties:
>> +
>> + - compatible:		Should be set to "ti,gpmc"
> 
> Please, be specific. Use something like "ti,am3340-gpmc" or
> "ti,omap3430-gpmc". The compatible property is a list so that new
> devices can claim compatibility with old. Compatible strings that are
> overly generic are a pet-peave of mine.

We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
(which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
implying all omap2+ based devices or should we have a compatible string
for each device supported?

Thanks
Jon
