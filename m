From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC PATCH 5/8] misc: emif: handle frequency and voltage change
 events
Date: Thu, 16 Feb 2012 16:52:00 +0530
Message-ID: <4F3CE6D8.1050703@ti.com>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com> <1328357771-31644-6-git-send-email-aneesh@ti.com> <4F3CDC9A.2000303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F3CDC9A.2000303@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Thursday 16 February 2012 04:08 PM, Santosh Shilimkar wrote:
> On Saturday 04 February 2012 05:46 PM, Aneesh V wrote:
>> Change SDRAM timings and other settings as necessary
>> on voltage and frequency changes. We calculate these
>> register settings based on data from the device data
>> sheet and inputs such a frequency, voltage state(stable
>> or ramping), temperature level etc.
>>
> May be you want add TBD or FIXME for notifiers when they
> are available. Do that in commit log as well as
> in the code so that we don't forget about it.

Will do.

>
>> Signed-off-by: Aneesh V<aneesh@ti.com>
>> ---
> Rest of the patch looks fine.
