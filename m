From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: AM43xx: Touchscreen support
Date: Mon, 19 May 2014 11:46:20 +0300
Message-ID: <5379C4DC.8050004@ti.com>
References: <1398861805-9229-1-git-send-email-rogerq@ti.com> <20140506163943.GL18474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbaESIqY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 04:46:24 -0400
In-Reply-To: <20140506163943.GL18474@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: bcousson@baylibre.com, mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi Tony,

On 05/06/2014 07:39 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [140430 05:43]:
>> Hi Benoit & Tony,
>>
>> These patches add I2C touch screen support for am43x-epos-evm
>> and am437x-gp-evm.
>>
>> Relevant driver side changes are here.
>> http://thread.gmane.org/gmane.linux.kernel.input/35803
>>
>> Please queue this for -next (3.16). Thanks.
> 
> Applying both into omap-for-v3.16/dt thanks.

There has been a change in the DT bindings [1]. i.e. x-size, y-size now become touchscreen-size-x and touchscreen-size-y. I will send a v2 for this series. Please drop these patches and take the v2 instead. Thanks.

cheers,
-roger

[1] - http://article.gmane.org/gmane.linux.kernel/1706454
