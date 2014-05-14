From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v4 1/6] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Wed, 14 May 2014 09:12:17 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACCDFD@DBDE04.ent.ti.com>
References: <1399668015-10499-1-git-send-email-pekon@ti.com>
 <1399668015-10499-2-git-send-email-pekon@ti.com> <53732400.4090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40349 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaENJMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 05:12:22 -0400
In-Reply-To: <53732400.4090107@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros, Roger" <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Roger,

>On 05/09/2014 11:40 PM, Pekon Gupta wrote:
[...]

>> +
>> +&elm {
>> +     status = "disabled";
>> +};
>> +
>> +&gpmc {
>> +     status = "disabled";
>> +};
>
>Why are you disabling the elm and gpmc modules here?
>Shouldn't they be disabled by default in the soc.dtsi file?
>
Yes both GPMC and ELM are 'disabled' by default in am33xx.dtsi.
I'll remove these duplicates in next version.
Thanks for pointing. Similar issue was also pointed out by Tony [1].

with regards, pekon

>cheers,
>-roger
>
[1] http://www.spinics.net/lists/linux-omap/msg106920.html


