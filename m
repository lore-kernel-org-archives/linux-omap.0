From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel
 driver
Date: Mon, 18 Feb 2013 13:03:21 +0530
Message-ID: <5121D941.3060609@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-17-git-send-email-archit@ti.com> <20130213172913.GD21750@blackmetal.musicnaut.iki.fi> <511C896C.10007@ti.com> <511C8B16.5060605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59527 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab3BRHeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 02:34:10 -0500
In-Reply-To: <511C8B16.5060605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 14 February 2013 12:28 PM, Tomi Valkeinen wrote:
> On 2013-02-14 08:51, Archit Taneja wrote:
>> On Wednesday 13 February 2013 10:59 PM, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
>>>> +static struct panel_acx565akm_data *get_panel_data(struct
>>>> omap_dss_device *dssdev)
>>>> +{
>>>> +    return (struct panel_acx565akm_data *) dssdev->data;
>>>> +}
>>>> +
>>>>    static int acx_panel_probe(struct omap_dss_device *dssdev)
>>>>    {
>>>>        int r;
>>>>        struct acx565akm_device *md = &acx_dev;
>>>> +    struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);
>>>
>>> Why the get_panel_data function is needed, isn't the cast unnecessary?
>>
>> the 'data' member of omap_dss_device has the type 'void *', we need to
>> cast it to access the panel_acx565akm_data struct pointer.
>
> You don't need an explicit cast to assign a void pointer to a pointer to
> something else (or vice versa, I think).
>
> I remember us having similar constructs in some other panel drivers
> also. I think they are unnecessary also.

I was considering keeping the get_panel_data() funcs in the panel 
drivers though. This way, whenever the way of retrieving platform data 
changes because of DT or CDF or something else, we would just need to 
modify the get_panel_data func.

Archit

