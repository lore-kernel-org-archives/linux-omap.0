From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Linux OMAP 2.6.30 kernel not booting
Date: Wed, 17 Jun 2009 20:35:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D1869@dbde02.ent.ti.com>
References: <213F5EBECAA75243A2F795E0D16AFF6AD8893BF9@dlee07.ent.ti.com>
 <418C1D1D75DA034D9CD5F5219FA619C057EB748C@dlee07.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D14BB@dbde02.ent.ti.com>
 <418C1D1D75DA034D9CD5F5219FA619C057EB776E@dlee07.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D14E0@dbde02.ent.ti.com>
 <20090617063545.GB6605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49408 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZFQPFW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 11:05:22 -0400
In-Reply-To: <20090617063545.GB6605@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gunasekera, Nipuna" <gunasekera@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>
>* Pandita, Vikram <vikram.pandita@ti.com> [090616 15:56]:
>>
>> >-----Original Message-----
>> >From: Gunasekera, Nipuna
>> >
>> >Thanks Vikram.  I'm able to move further in the booting process using arm-2008q3-72.  However, I'm
>> >still getting a kernel panic and I'm not sure why.  If you or some others have experienced this
>> >please let me know.
>>
>> There are some pending patches that are still under review and not merged that are needed for the
>zoom2 to work of Linux-omap master.
>>
>> Linux-Omap pending patches in patchworks:
>> MMC mux fix:
>> http://patchwork.kernel.org/patch/30445/
>> http://patchwork.kernel.org/patch/30446/
>> Zoom2 T2 enabling:
>> http://patchwork.kernel.org/patch/30001/
>> http://patchwork.kernel.org/patch/30002/
>> File system loading issue:
>> http://patchwork.kernel.org/patch/29668/
>>
>>
>> Serial driver pending patch:
>> http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach
>>
>>
>> I hope all these dependencies will make it soon to their respective trees.
>
>Also, please check that your .config has CONFIG_REGULATOR enabled and the
>associated twl4030 regulator.

That is done as part of patches already submitted and waiting for your merge.

Zoom2 T2 enabling:
http://patchwork.kernel.org/patch/30001/
http://patchwork.kernel.org/patch/30002/

>
>Tony

