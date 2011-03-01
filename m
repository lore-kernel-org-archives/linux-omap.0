From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Tue, 1 Mar 2011 19:06:00 +0530
Message-ID: <4D6CF640.8010301@ti.com>
References: <1298982743-6771-1-git-send-email-archit@ti.com> <1298982743-6771-2-git-send-email-archit@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB037A21436B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab1CANdK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 08:33:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21DX7VD026973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 07:33:09 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p21DX6um021531
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 19:03:06 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A21436B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 01 March 2011 06:50 PM, DebBarma, Tarun Kanti wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Taneja, Archit
>> Sent: Tuesday, March 01, 2011 6:02 PM
>> To: Valkeinen, Tomi
>> Cc: linux-omap@vger.kernel.org; Taneja, Archit
>> Subject: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
>>
>> Introduce functions which request and release VC's. This will be used in
>> panel
>> drivers in their probes.
>>
>> omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the
>> VC_ID
>> parameter which goes into the header of the DSI packets, and returns a
>> Virtual
>> channel number (or virtual channel register set) which it can use.
>>
>> omap_dsi_set_vc_id() takes the omap_dss_device pointer, the Virtual
>> Channel
>> number and the VC_ID that needs to be set for the specifed Virtual
>> Channel.
>>
>> omap_dsi_releae_vc() takes the omap_dss_device pointer and the Virtual
>> Channel
>> number that needs to be made free.
>>
>> Initialisation of VC parameters is done in dsi_init().
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>

<snip>

>> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
> Since this is an export function it might be good to have standard comment
> Header.

Its meant to be used by another folder which is also a part of DSS2, 
other functions exported in this file don't have comments on them 
either. Not totally sure if comments are needed for this or not.

>> +{
>> +	int i;
>> +
>> +	for (i = 0; i<  4; i++) {
> Does it make sense to use a constant instead of hard coding 4?

This is a property of DSI HW which is quite unlikely to change with 
later version of OMAPs.

>> +		if (!dsi.vc[i].dssdev) {
>> +			dsi.vc[i].dssdev = dssdev;
>> +			*channel = i;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	DSSERR("cannot get VC for display %s", dssdev->name);
>> +	return -ENOSPC;
>> +}
>> +EXPORT_SYMBOL(omap_dsi_request_vc);
>> +
>> +int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int
>> vc_id)
>> +{
>> +	if (vc_id<  0 || vc_id>  4) {
>> +		DSSERR("VC ID out of range\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dsi.vc[channel].dssdev == dssdev) {
>> +		dsi.vc[channel].vc_id = vc_id;
>> +		return 0;
>> +	}
>> +
> Might be a good idea to print some type of error message here?

The user of this function checks for errors and prints an error message 
very similar to what we would print here. Thats why I decided to skip here.

>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(omap_dsi_set_vc_id);
>> +
>> +void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
>> +{
>> +	if (dsi.vc[channel].dssdev == dssdev) {
>> +		dsi.vc[channel].dssdev = NULL;
> Don't we have to free dssdev? Unless it is getting freed else where?

Its not really allocated at boot time, its a static structure filled up 
in the board file, setting to NULL just lets omap_dsi_request_vc() reuse it.

Thanks,
Archit
