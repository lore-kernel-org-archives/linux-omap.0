From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/16] remoteproc: Add a rproc_set_firmware() API
Date: Thu, 29 Nov 2018 10:51:01 +0200
Message-ID: <5BFFA875.6020002@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-3-git-send-email-rogerq@ti.com>
 <ee68d58b-24ff-f7b2-aa62-f1e73e078516@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee68d58b-24ff-f7b2-aa62-f1e73e078516@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 26/11/18 23:41, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> A new API, rproc_set_firmware() is added to allow the remoteproc platform
>> drivers and remoteproc client drivers to be able to configure a custom
>> firmware name that is different from the default name used during
>> remoteproc registration. This function is being introduced to provide
>> a kernel-level equivalent of the current sysfs interface to remoteproc
>> client drivers. This allows some remoteproc drivers to choose different
>> firmwares at runtime when the remote processor is not running based on
>> the functional feature it is providing using that remote processor.
>> The TI PRU Ethernet driver will be an example of such usage as it
>> requires to use different firmwares for different supported protocols.
>>
>> Also, update the firmware_store() function used by the sysfs interface
>> to reuse this function to avoid code duplication.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c  | 61 +++++++++++++++++++++++++++++++++++
>>   drivers/remoteproc/remoteproc_sysfs.c | 33 ++-----------------
>>   include/linux/remoteproc.h            |  1 +
>>   3 files changed, 64 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 39458a7..581e6e8 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -2151,6 +2151,67 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
> 
> ...
> 
>> +int rproc_set_firmware(struct rproc *rproc, const char *fw_name)
>> +{
>> +    struct device *dev = rproc->dev.parent;
>> +    int ret, len;
>> +    char *p;
>> +
>> +    if (!rproc || !fw_name)
>> +        return -EINVAL;
>> +
>> +    ret = mutex_lock_interruptible(&rproc->lock);
>> +    if (ret) {
>> +        dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (rproc->state != RPROC_OFFLINE) {
>> +        dev_err(dev, "can't change firmware while running\n");
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    len = strcspn(fw_name, "\n");
>> +    if (!len) {
>> +        dev_err(dev, "can't provide a NULL firmware\n");
> 
> I realize this was just copied, but technically, this would be an
> empty string rather than NULL.
> 
Noted. Thanks.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
