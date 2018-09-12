From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
Date: Wed, 12 Sep 2018 16:49:39 +0530
Message-ID: <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 12 September 2018 04:32 PM, Sudeep Holla wrote:
> 
> 
> On 12/09/18 05:09, Keerthy wrote:
>> Introuduce linux generic suspend states supported properties.
>> It is convenient for the generic suspend path to have
>> the knowledge of the suspend states supported based on the
>> device tree properties based on which it can either be suspended
>> or safely bailed out of suspend if none of the suspend states
>> are supported.
>>
> 
> NACK for any bindings that are linux specific. The suspend feature is so
> platform dependent that I see no need for generic Linux bindings for the
> same.

suspend to mem and suspend to disk are pretty generic states and i agree
implementation is platform dependent so why not have properties that
convey if they are supported?

Is the disagreement over making the properties being linux specific?

> 
> We have power domains and idle states. If you have platforms that
> doesn't support some of the states, just disable them in the DT.
> 
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  .../devicetree/bindings/power/power-states.txt     | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/power-states.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power-states.txt b/Documentation/devicetree/bindings/power/power-states.txt
>> new file mode 100644
>> index 0000000..bb80b36
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power-states.txt
>> @@ -0,0 +1,22 @@
>> +* Generic system suspend states support
>> +
>> +Most platforms support multiple suspend states. Define system
>> +suspend states so that one can target appropriate low power
>> +states based on the SoC capabilities.
>> +
>> +linux,suspend-to-memory-supported
>> +
>> +Upon suspend to memory the system context is saved to primary memory.
>> +All the clocks for all the peripherals including CPU are gated.
>> +
>> +linux,suspend-power-off-supported
>> +
>> +In this case in additon to the clocks all the voltage resources are
>> +turned off except the ones needed to keep the primary memory
>> +and a wake up source that can trigger a wakeup event.
>> +
>> +linux,suspend-to-disk-supported
>> +
>> +Upon suspend to disk that system context is saved to secondary memory.
>> +All the clocks for all the peripherals including CPU are gated. Even
>> +the primary memory is turned off.
>>
> 
> What makes any of the above linux specific. So once again NACK.
> 
> 
