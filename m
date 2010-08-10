From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] [RFC] Remove the debug print noise
Date: Tue, 10 Aug 2010 14:52:43 +0300
Message-ID: <20100810115243.GE22436@nokia.com>
References: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401D991@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30253 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0HJLxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 07:53:34 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401D991@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 10, 2010 at 12:39:32PM +0200, ext DebBarma, Tarun Kanti wrote:
>> @@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>>  	if (r < 0)
>>  		return r;
>>  	if (r == 0) {
>> -		dev_err(dev->dev, "controller timed out\n");
>> +		dev_dbg(dev->dev, "controller timed out\n");
>
>Did you compile the code? I thought it would be as below:
>dev_dbg(&dev->dev, "controller timed out\n");

read the code more carefully. Check the definition of struct 
omap_i2c_dev. It holds a pointer to a struct device already.

-- 
balbi

DefectiveByDesign.org
