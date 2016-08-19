From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: switch to using remoteproc OF
 infrastructure
Date: Fri, 19 Aug 2016 16:35:21 -0500
Message-ID: <a18ac529-27d1-a98b-dcfa-82f5c03197fe@ti.com>
References: <20160812003529.519-1-s-anna@ti.com> <20160812110201.GD25844@dell>
 <55d90506-eb1b-c8f9-02b5-8484b9a4babd@ti.com>
 <20160812164335.GG26240@tuxbot>
 <CAL_Jsq+aOd-FqaKNtmDESw--pdxbWMuOzv+KXf-hhX+oU94CdQ@mail.gmail.com>
 <dea62d2e-2935-ff91-967a-e8dee469543d@ti.com>
 <CAL_JsqLDWkpiZx2PTa11T-ynW=meCwq=tiNK6C2-U4-q5qrYDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqLDWkpiZx2PTa11T-ynW=meCwq=tiNK6C2-U4-q5qrYDw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-remoteproc@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/19/2016 04:21 PM, Rob Herring wrote:
> On Thu, Aug 18, 2016 at 4:30 PM, Suman Anna <s-anna@ti.com> wrote:
>> Hi Rob,
>>
>> On 08/16/2016 09:54 AM, Rob Herring wrote:
>>> On Fri, Aug 12, 2016 at 11:43 AM, Bjorn Andersson
>>> <bjorn.andersson@linaro.org> wrote:
>>>> On Fri 12 Aug 09:00 PDT 2016, Suman Anna wrote:
>>>>
>>>>> On 08/12/2016 06:02 AM, Lee Jones wrote:
>>>>>> On Thu, 11 Aug 2016, Suman Anna wrote:
>>>>>>
> 
> [...]
> 
>>>>> Once "rprocs" hits mainline, I will definitely switch over the
>>>>> wkup_m3_ipc nodes to use that standard property and can fix this driver
>>>>> independently.
>>>>>
>>>>
>>>> We're stuck with this problem all over the place, as the world continues
>>>> to evolve we will have issues with DT being static. This has been
>>>> discussed many times before and the suggested solution is always what
>>>> you implemented here - make the code deal with both versions, preferably
>>>> by patching.
>>>>
>>>> The fact that you had to export the of_ operations indicates that no-one
>>>> has tried this before and I'm happy you did. I'm however not happy about
>>>> the size of the chunk of code it takes to do this dance.
>>>>
>>>> I think for this to be practical we need to provide higher level
>>>> operations for DT modification - in this case a of_rename_property().
>>>>
>>>> @Rob, any comments on this?
>>>
>>> I agree. Pantelis submitted some helpers in this area a while back
>>> (for the changeset API IIRC). I believe they were mostly fine, but
>>> needed some users.
>>>
>>
>> Is this the series you are talking about?
>> http://marc.info/?l=devicetree&m=146341689512653&w=2
>>
>> It looks like that series is effective only when OF_DYNAMIC is enabled.
> 
> Yes, as changeset API allows adding/removing nodes. It's probably just
> a matter of time until OF_DYNAMIC is always enabled.
> 
>> Probably a dumb question, but is this limited to DT Overlays?
> 
> No, changesets are the mechanism overlays use to apply changes.
> 
>> This
>> particular usage is a one-time change (first-time module is insmod'd)
>> mainly to provide compatibility for older DTBs, thereafter we wouldn't
>> be required to make any changes. It is definitely not a bulk update and
>> we don't want to unroll the changes even if we removed the module.
> 
> If you only need property changes, then we could do similar helpers to
> make it easier for callers.

So if you are ok with an of_rename_property() API, I can submit a patch
for the same.

regards
Suman
