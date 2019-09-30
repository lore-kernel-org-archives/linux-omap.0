From: keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 linux-next 4/4] arm64: configs: defconfig: Change
 CONFIG_REMOTEPROC from m to y
Date: Tue, 1 Oct 2019 04:40:47 +0530
Message-ID: <0c8dcf78-6f9e-f47f-1175-90b716cdad84@ti.com>
References: <20190920075946.13282-1-j-keerthy@ti.com>
 <20190920075946.13282-5-j-keerthy@ti.com>
 <20190930134856.umdoeq7k6ukmajij@willie-the-truck>
 <CAOesGMgs7rKOVnimDwSpeGTAf93Er+Ymzy9-R-mKkQK6MQcF3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMgs7rKOVnimDwSpeGTAf93Er+Ymzy9-R-mKkQK6MQcF3Q@mail.gmail.com>
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
To: Olof Johansson <olof@lixom.net>, Will Deacon <will@kernel.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Tero Kristo <t-kristo@ti.com>, hch@lst.de, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 10/1/2019 12:16 AM, Olof Johansson wrote:
> On Mon, Sep 30, 2019 at 6:49 AM Will Deacon <will@kernel.org> wrote:
>>
>> On Fri, Sep 20, 2019 at 01:29:46PM +0530, Keerthy wrote:
>>> Commit 6334150e9a36 ("remoteproc: don't allow modular build")
>>> changes CONFIG_REMOTEPROC to a boolean from a tristate config
>>> option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
>>> a module in compiling the remoteproc and dependent config options.
>>>
>>> So fix the defconfig to have CONFIG_REMOTEPROC built in.
>>>
>>> Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>   arch/arm64/configs/defconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 8e05c39eab08..c9a867ac32d4 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -723,7 +723,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>>>   CONFIG_ARM_SMMU=y
>>>   CONFIG_ARM_SMMU_V3=y
>>>   CONFIG_QCOM_IOMMU=y
>>> -CONFIG_REMOTEPROC=m
>>> +CONFIG_REMOTEPROC=y
>>>   CONFIG_QCOM_Q6V5_MSS=m
>>>   CONFIG_QCOM_Q6V5_PAS=m
>>>   CONFIG_QCOM_SYSMON=m
>>
>> Acked-by: Will Deacon <will@kernel.org>
>>
>> This fixes the following annoying warning from "make defconfig" on arm64:
>>
>>    arch/arm64/configs/defconfig:726:warning: symbol value 'm' invalid for REMOTEPROC
>>
>> I'm assuming the fix will go via arm-soc, but I can take it otherwise
>> (please just let me know).
> 
> Thanks, I'll pick this up, but I'll squash the 4 one-line changes into
> one commit instead of separate patches.

Thanks Olof.

> 
> 
> -Olof
> 
