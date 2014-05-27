From: Archit Taneja <archit@ti.com>
Subject: Re: [RFC v2 2/5] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Tue, 27 May 2014 15:19:13 +0530
Message-ID: <53845F99.60603@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-2-git-send-email-archit@ti.com> <53844E14.9090504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbaE0Ju3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 05:50:29 -0400
Received: from dbdlxv05.itg.ti.com ([172.24.171.60])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4R9oROK011161
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 04:50:28 -0500
Received: from DBDE72.ent.ti.com (dbde72.ent.ti.com [172.24.171.97])
	by dbdlxv05.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4R9oOex025717
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 15:20:26 +0530
In-Reply-To: <53844E14.9090504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 27 May 2014 02:04 PM, Tomi Valkeinen wrote:
> On 26/05/14 12:28, Archit Taneja wrote:
>> In omapdss_of_find_source_for_first_ep, we retrieve a source endpoint's DT node,
>> and then see what omapdss output has the matching device_node pointer in
>> omap_dss_find_output_by_node.
>>
>> For all DPI and SDI outputs, the device_node pointer is set as the parent's DSS
>> device_node pointer. If the source is one of these outputs, the above method
>> won't work.
>>
>> To get the correct output for ports within DSS(and in other cases in the future,
>> where multiple ports might be under one device), we require additional
>> information which is exclusive to the output port.
>>
>> We create a new field in omap_dss_device called 'port_num', this provides port
>> number of the output port corresponding to this device. When searching for the
>> source endpoint in DT, we extract the 'reg' property from the port corresponding
>> to the endpoint source. From the list of registered outputs, we pick out that
>> output which has both dev->of_node and port_num matching with the device_node
>> pointer and 'reg' of the source endpoint node from DT.
>>
>> For encoder blocks(the ones which have both an input and output port), we need
>> to set the port_num as the 'reg' property for the output port as defined in the
>> DT bindings. We set port_num to 1 in the tfp410 and tpd12s015 encoder drivers.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   .../fbdev/omap2/displays-new/encoder-tfp410.c      |  1 +
>>   .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  1 +
>>   drivers/video/fbdev/omap2/dss/dss-of.c             | 51 +++++++++++++++++-----
>>   drivers/video/fbdev/omap2/dss/output.c             |  8 ++--
>>   include/video/omapdss.h                            |  7 ++-
>>   5 files changed, 52 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
>> index b4e9a42..d927455 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
>> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
>> @@ -249,6 +249,7 @@ static int tfp410_probe(struct platform_device *pdev)
>>   	dssdev->output_type = OMAP_DISPLAY_TYPE_DVI;
>>   	dssdev->owner = THIS_MODULE;
>>   	dssdev->phy.dpi.data_lines = ddata->data_lines;
>> +	dssdev->port_num = 1;
>>
>>   	r = omapdss_register_output(dssdev);
>>   	if (r) {
>> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
>> index 7e33686..9e25fe7 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
>> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
>> @@ -389,6 +389,7 @@ static int tpd_probe(struct platform_device *pdev)
>>   	dssdev->type = OMAP_DISPLAY_TYPE_HDMI;
>>   	dssdev->output_type = OMAP_DISPLAY_TYPE_HDMI;
>>   	dssdev->owner = THIS_MODULE;
>> +	dssdev->port_num = 1;
>>
>>   	in = ddata->in;
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbdev/omap2/dss/dss-of.c
>> index a4b20aa..8ba43faa 100644
>> --- a/drivers/video/fbdev/omap2/dss/dss-of.c
>> +++ b/drivers/video/fbdev/omap2/dss/dss-of.c
>> @@ -132,28 +132,55 @@ EXPORT_SYMBOL_GPL(omapdss_of_get_first_endpoint);
>>   struct omap_dss_device *
>>   omapdss_of_find_source_for_first_ep(struct device_node *node)
>>   {
>> -	struct device_node *ep;
>> -	struct device_node *src_node;
>> +	struct device_node *ep, *port_ep;
>> +	struct device_node *src_node, *src_port;
>>   	struct omap_dss_device *src;
>> +	int r;
>> +	u32 reg;
>>
>>   	ep = omapdss_of_get_first_endpoint(node);
>> -	if (!ep)
>> -		return ERR_PTR(-EINVAL);
>> +	if (!ep) {
>> +		r = -EINVAL;
>> +		goto err_first_ep;
>> +	}
>>
>>   	src_node = omapdss_of_get_remote_device_node(ep);
>> +	if (!src_node) {
>> +		r = -EINVAL;
>> +		goto err_src_node;
>> +	}
>>
>> -	of_node_put(ep);
>> -
>> -	if (!src_node)
>> -		return ERR_PTR(-EINVAL);
>> +	port_ep = of_parse_phandle(ep, "remote-endpoint", 0);
>> +	if (!port_ep) {
>> +		r = -EINVAL;
>> +		goto err_port_ep;
>> +	}
>>
>> -	src = omap_dss_find_output_by_node(src_node);
>> +	src_port = of_get_next_parent(port_ep);
>> +	if (!src_port) {
>> +		r = -EINVAL;
>> +		goto err_src_port;
>> +	}
>>
>> -	of_node_put(src_node);
>> +	r = of_property_read_u32(src_port, "reg", &reg);
>> +	if (r) {
>> +		r = 0;
>> +		reg = 0;
>> +	}
>>
>> +	src = omap_dss_find_output_by_node_and_reg(src_node, reg);
>>   	if (!src)
>> -		return ERR_PTR(-EPROBE_DEFER);
>> +		r = -EPROBE_DEFER;
>
> Hmm, maybe the above function, and the helper functions, should be
> changed a bit more, so that this function would do:
>
> ep = omapdss_of_get_first_endpoint(node);
> src_port = omapdss_of_get_remote_port(ep);
> src = omap_dss_find_output_by_port_node(src_port);

src_port will be just on level up(the parent node), the source node will 
be still a couple of hops up.

Getting the source node would require us to do some DT related hopping 
in omap_dss_find_output_by_port_node(). And it'll also require parsing 
of the dss output_list in output.c. I'm worried it'll be a bit messy, 
and we might end up adding some DT parsing in output.c

Archit

