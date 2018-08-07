From: Suman Anna <s-anna@ti.com>
Subject: Re: New remoteproc driver for TI PRU
Date: Mon, 6 Aug 2018 20:39:44 -0500
Message-ID: <a377163f-e7a5-1f35-02ad-f223fc2c6e9d@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
 <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
 <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
 <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
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
To: David Lechner <david@lechnology.com>, Roger Quadros <rogerq@ti.com>, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi David,

On 08/06/2018 11:32 AM, David Lechner wrote:
> On 06/29/2018 07:17 PM, Suman Anna wrote:
>> Hi David,
>>
>> On 06/29/2018 12:44 PM, David Lechner wrote:
>>> On 06/29/2018 04:58 AM, Roger Quadros wrote:
>>>> +Suman & Tero
>>>>
>>>> Hi David,
>>>>
>>>> On 24/06/18 00:08, David Lechner wrote:
>>>>>
>>>>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>>>>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>>>>
>>>>> This series adds a new remoteproc driver for the TI Programmable
>>>>> Runtime Unit
>>>>> (PRU) that is present in some TI Sitara processors. This code has
>>>>> been tested
>>>>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
>>>>
>>>> This is great. We have been working on something similar and I think
>>>> it would
>>>> be great if we can collaborate to get all our needs addressed.
>>>
>>> Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen
>>> the TI
>>> implementation. My primary interest is in the AM1808, which has a far
>>> simpler
>>> PRU than other SoCs. So, I was hoping I could get away with just
>>> implementing
>>> the basic stuff that I need and let TI add the more complex stuff later.
>>
>> Thanks for the series. PRUSS is present on many SoCs now, and each with
>> their own integration quirks, both in terms of SoC connections as well
>> as internal sub-modules within the subsystem. We currently support
>> AM335x, AM437x, AM57xx, Keystone 2 based 66AK2G and a newer generation
>> AM65x as well. It should be relatively straight-forward to scale this
>> for AM1808/OMAP-L138 as well. The move to the standard Common Clock and
>> Reset frameworks for clocks with the Davinci chips should make it
>> relatively straight-forward for the architecture pieces.
>>
>> I will take a look at your series in detail sometime next week, and
>> mostly post our series to the upstream lists as well within the next
>> couple of weeks so that it is easier for discussion on the upstream
>> lists.
>>
> 
> Have you had time to look at this yet? If you are too busy, I can submit
> a v2 with the interrupt controller broken out into a separate driver.

Yeah, I worked on it a bit around -rc4 time, but didn't get a chance to
complete the cleanup & testing before I had to shift to some other
tasks. If you are interested, I can share my branch. I will mostly get
back to this towards the latter half of next week. Anyway, I am
expecting 4.19-rc1 to be in a better shape w.r.t Davinci platform as the
genpd and CCF stuff comes in, and the pm_runtime usage for clocking in
my PRUSS drivers will fit well with those available.

regards
Suman
