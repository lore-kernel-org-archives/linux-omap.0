From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] mfd: lp87565: Add lp87565 PMIC support
Date: Sun, 11 Jun 2017 10:36:51 +0530
Message-ID: <7596b39a-3135-7cca-e3dc-18c05cf54a8b@ti.com>
References: <1496894894-6969-1-git-send-email-j-keerthy@ti.com>
 <20170609142855.tfixhw3cb5qjkcne@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170609142855.tfixhw3cb5qjkcne@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 09 June 2017 07:58 PM, Rob Herring wrote:
> On Thu, Jun 08, 2017 at 09:38:14AM +0530, Keerthy wrote:
>> The LP87565 chip is a power management IC for Portable Navigation Systems
>> and Tablet Computing devices. It contains the following components:
>>
>>         - Configurable Bucks(Single and multi-phase).
>>         - Configurable General Purpose Output Signals (GPO).
>>
>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
>> output.
>>
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> ---
>>
>> The other patches are already pulled by Mark. Hence posting
>> the remaining patch.
>>
>> Changes in v4:
>>
>>   * Fixed device tree comments from Rob on the pmic node name.
>>   * removed regulators from properties list as it is a node.
>>  
>> Changes in v3:
>>
>>   * Fixed License to GPL v2.
>>   * Fixed an indentation issue.
>>
>> Changes in v2:
>>
>>   * Fixed a bunch of whitespace errors.
>>   * Changed the License to short form.
>>   * Added the generic compatible lp87565
>>   * Removed i2c_device_id table.
>>   * Introduced probe_new function in place of probe.
>>
>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  43 ++++
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks Rob.

> 
>>  drivers/mfd/Kconfig                               |  14 ++
>>  drivers/mfd/Makefile                              |   1 +
>>  drivers/mfd/lp87565.c                             |  92 ++++++++
>>  include/linux/mfd/lp87565.h                       | 270 ++++++++++++++++++++++
>>  5 files changed, 420 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>>  create mode 100644 drivers/mfd/lp87565.c
>>  create mode 100644 include/linux/mfd/lp87565.h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
