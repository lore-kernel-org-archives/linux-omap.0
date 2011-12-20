From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram
 controller
Date: Tue, 20 Dec 2011 12:42:02 +0530
Message-ID: <4EF03542.6000303@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<1324303533-17458-3-git-send-email-aneesh@ti.com> <CAOesGMi79_4EH58rErxkBNevEUeCf56pSfEG2A4ejD4b4pNf-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58385 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204Ab1LTHMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 02:12:09 -0500
Received: by mail-yx0-f173.google.com with SMTP id m6so4057524yen.32
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 23:12:08 -0800 (PST)
In-Reply-To: <CAOesGMi79_4EH58rErxkBNevEUeCf56pSfEG2A4ejD4b4pNf-A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Monday 19 December 2011 10:26 PM, Olof Johansson wrote:
> Hi,
>
> Fewer comments here. :) But see below.
>
> On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V<aneesh@ti.com>  wrote:
>
>
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
>> @@ -0,0 +1,64 @@
>> +* EMIF family of TI SDRAM controllers
>> +
>> +EMIF - External Memory Interface - is an SDRAM controller used in
>> +TI SoCs. EMIF supports, based on the IP revision, one or more of
>> +DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
>> +of the EMIF IP and memory parts attached to it.
>> +
>> +Required properties:
>> +- compatible   : One or more of "ti,emif-ddr2", "ti,emif-ddr3", and
>> +  "ti,emif-lpddr2"
>> +
>> +  "ti,emif-ddr2" should be listed of the EMIF controller on this SoC
>> +  supports DDR2 memories
>> +
>> +  "ti,emif-ddr3" should be listed of the EMIF controller on this SoC
>> +  supports DDR3 memories
>> +
>> +  "ti,emif-lpddr2" should be listed of the EMIF controller on this SoC
>> +  supports LPDDR2 memories
>> +
>> +- ti,hwmods    : For TI hwmods processing and omap device creation
>> +  the value shall be "emif<n>" where<n>  is the number of the EMIF
>> +  instance with base 1.
>> +
>> +- phy-type     : string indicating the phy type. Should be one of the
>> +  following:
>> +
>> +  "phy-type-omap4"  : PHY used in OMAP4 family of SoCs
>> +
>> +  "phy-type-dm81xx" : PHY used in DM81XX family of SoCs
>> +
>> +- ddr-handle   : phandle to a "ddr" node representing the memory part
>> +  attached to this EMIF instance.
>
> Just specify said ddr node as a child of this node instead of give it
> a handle. What other bus would the ddr node sit on, if not the memory
> controller bus?

We have two SDRAM controller instances and two separate channels.
Typically, the two channels will have same type of memory attached. I
did this avoid duplication of data. Is that fine?

thanks,
Aneesh
