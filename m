From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
Date: Wed, 17 Oct 2018 16:36:21 +0300
Message-ID: <d12256f8-d0f6-ba13-e43b-67ac3a1ac25c@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com> <20181017132501.GA19385@bogus>
 <6e9e90a1-0580-cc20-f7f9-69fefae0b3dd@gmail.com>
 <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/17/18 4:33 PM, Rob Herring wrote:
> On Wed, Oct 17, 2018 at 8:32 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> On 10/17/18 4:25 PM, Rob Herring wrote:
>>> On Fri, Oct 05, 2018 at 06:36:32PM +0300, Dmitry Osipenko wrote:
>>>> Redefine binding for regulator-coupled-max-spread property in a way that
>>>> max-spread values are defined per regulator couple instead of defining
>>>> single max-spread for the whole group of coupled regulators.
>>>>
>>>> With that change the following regulators coupling configuration will be
>>>> possible:
>>>>
>>>> regA: regulatorA {
>>>>      regulator-coupled-with = <&regB &regC>;
>>>>      regulator-coupled-max-spread = <100000 300000>;
>>>> };
>>>>
>>>> regB: regulatorB {
>>>>      regulator-coupled-with = <&regA &regC>;
>>>>      regulator-coupled-max-spread = <100000 200000>;
>>>> };
>>>>
>>>> regC: regulatorC {
>>>>      regulator-coupled-with = <&regA &regB>;
>>>>      regulator-coupled-max-spread = <300000 200000>;
>>>> };
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> index a7cd36877bfe..9b525b657fca 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> @@ -76,8 +76,9 @@ Optional properties:
>>>>  - regulator-coupled-with: Regulators with which the regulator
>>>>    is coupled. The linkage is 2-way - all coupled regulators should be linked
>>>>    with each other. A regulator should not be coupled with its supplier.
>>>> -- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
>>>> -  in microvolts.
>>>> +- regulator-coupled-max-spread: Array of maximum spread between voltages of
>>>> +  coupled regulators in microvolts, each value in the array relates to the
>>>> +  corresponding couple specified by the regulator-coupled-with property.
>>>
>>> Is this in use already? How is a single entry handled?
>>
>> No, it is not in use yet. Only some of the prerequisite patches were applied.
> 
> Please make that clear in the commit message.

Okay.
