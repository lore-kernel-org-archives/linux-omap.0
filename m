From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Thu, 29 Aug 2013 17:20:29 -0500
Message-ID: <521FC92D.1080601@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <5211E3F6.6090108@ti.com> <52125A39.3010008@ti.com> <87vc2qyjao.fsf@linaro.org> <521FBD6B.3020208@ti.com> <877gf4tb9q.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49234 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119Ab3H2WUx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 18:20:53 -0400
In-Reply-To: <877gf4tb9q.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On 08/29/2013 04:52 PM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
>
>> On 08/27/2013 03:23 PM, Kevin Hilman wrote:
>>> Hi Dave,
>>>
>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>
>>>> On 08/19/2013 04:23 AM, Gururaja Hebbar wrote:
>>>>> On 8/6/2013 11:19 PM, Dave Gerlach wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This is the third version of the patch series for adding basic suspend-resume
>>>>>> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset
>>>>>> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
>>>>>> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are
>>>>>> required for the pm code to properly suspend and resume.
>>>>>>
>>>>>> The PM code uses the firmware interface and expects the userspace to load
>>>>>> the WKUP_M3 binary before the suspend-resume functionality is made available.
>>>>>> The binary file (and the source-code for WKUP_M3) can be obtained from the
>>>>>> 'next2' branch at [4]. The WKUP_M3 binary can either be loaded post bootup
>>>>>> via the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or it can be
>>>>>> included in the kernel image as part of the build process.
>>>>>>
>>>>>> Suspend to mem is tested on am335x-bone and am335x-evm.
>>>>>>
>>>>>> More details on AM335x suspend-resume are provided within the commit logs
>>>>>> for each patch.
>>>>>
>>>>> can you share the working repo which has all these patches applied?
>>>>>
>>>>> Thanks & Regards
>>>>> Gururaja
>>>>>
>>>>
>>>> The working repo for this version of the patch series can be found here:
>>>>
>>>> git://github.com/dgerlach/linux-pm.git am335x-3.11rc4-suspend-resume
>>>
>>> I tried this branch on my beaglebone black, and it's not fully resuming.
>>> Suspend seems to be working (power draw goes from ~1W to ~130mW) and
>>> pressing a key on the UART seems to be waking up the SoC (power draw
>>> goes to ~600mW) but I don't ever get the console back.
>>>
>>> Is there a specific version of the firmware I should be using?
>>>
>>> Kevin
>>>
>>
>> Kevin, I agree there does seem to be some issues with Beaglebone
>> black. I can confirm it works on BeagleBone White and the large am335
>> EVM, I am working on pinpointing the issue on beaglebone black, seems
>> that support isn't quite there yet.
>
> OK, I didn't realize that.  I'll give it a try on my BB white.
>
> Is there a specific version/branch of the firmware I should be using?
>
> Thanks,
>
> Kevin
>

Kevin,

The next2 branch, which you can find here [1], is what this revision of 
the series was developed against and is tested and works.

Regards,
Dave

[1] 
http://arago-project.org/git/projects/?p=am33x-cm3.git;a=shortlog;h=refs/heads/next2
