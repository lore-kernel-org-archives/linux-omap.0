From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 08/14] OMAPDSS: DSS: add new clock calculation code
Date: Thu, 21 Mar 2013 11:44:46 +0530
Message-ID: <514AA556.4040300@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-9-git-send-email-tomi.valkeinen@ti.com> <5149D30F.2010801@ti.com> <5149D5A7.204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37682 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754528Ab3CUGPe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 02:15:34 -0400
In-Reply-To: <5149D5A7.204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 20 March 2013 08:58 PM, Tomi Valkeinen wrote:
> On 2013-03-20 17:17, Archit Taneja wrote:
>> On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
>>> Add new way to iterate over DSS clock divisors. dss_div_calc() provides
>>> a generic way to go over all the divisors, within given clock range.
>>> dss_div_calc() will call a callback function for each divider set,
>>> making the function reusable for all use cases.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/dss.c |   36
>>> ++++++++++++++++++++++++++++++++++++
>>>    drivers/video/omap2/dss/dss.h |    3 +++
>>>    2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/video/omap2/dss/dss.c
>>> b/drivers/video/omap2/dss/dss.c
>>> index 054c2a2..21a3dc8 100644
>>> --- a/drivers/video/omap2/dss/dss.c
>>> +++ b/drivers/video/omap2/dss/dss.c
>>> @@ -473,6 +473,42 @@ int dss_calc_clock_rates(struct dss_clock_info
>>> *cinfo)
>>>        return 0;
>>>    }
>>>
>>> +bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void
>>> *data)
>>> +{
>>> +    int fckd, fckd_start, fckd_stop;
>>> +    unsigned long fck;
>>> +    unsigned long fck_hw_max;
>>> +    unsigned long fckd_hw_max;
>>> +    unsigned long prate;
>>> +
>>> +    if (dss.dpll4_m4_ck == NULL) {
>>> +        /* XXX can we change the clock on omap2? */
>>
>> We can change dss_fclk1 on omap2, and the cclock2420_data.c and
>> cclock2430_data.c have clksel structs which allow a set of dividers. The
>> dividers are not continuous though, 1 to 12 and 16 are allowed. So we
>> might need to change the code here a bit, if we want to change the clock
>> in the first place.
>
> Ok, good to know. Note that the comment is copied from the old code. I
> think I tried changing the clock on N800 with clk_set_rate long ago, but
> I didn't get it to work. Things might have changed, but, well, I don't
> think we should spend time on omap2 code. I'm sure we'll get a patch if
> somebody needs it =).

We could change the comment to a TODO for now.

Archit

