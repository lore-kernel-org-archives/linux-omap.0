From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Mon, 19 Mar 2012 15:09:12 +0400
Message-ID: <4F6713D8.3080206@mvista.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com> <20120319100603.GB20279@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45591 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab2CSLKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 07:10:37 -0400
Received: by bkcik5 with SMTP id ik5so4162569bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 04:10:36 -0700 (PDT)
In-Reply-To: <20120319100603.GB20279@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

Hello.

On 19-03-2012 14:06, Felipe Balbi wrote:

>> +	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
>> +	if (ver == OMAP_USBTLL_REV1)
>> +		count = OMAP_TLL_CHANNEL_COUNT;
>> +	else if (ver == OMAP_USBTLL_REV2)
>> +		count = OMAP_REV2_TLL_CHANNEL_COUNT;
>> +	else {
>> +		dev_err(dev, "TLL version failed\n");
>> +		ret = -ENODEV;
>> +		goto err_ioremap;
>> +	}

> wrong coding style.

    And *switch* seems more fitting here.

WBR, Sergei
