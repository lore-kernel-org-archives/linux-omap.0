From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH-V2 1/3] RTC:s35390a: Add Alarm interrupt support
Date: Mon, 23 Aug 2010 09:29:57 +0300
Message-ID: <20100823062957.GA1068@nokia.com>
References: <hvaibhav@ti.com>
 <1282393829-7326-2-git-send-email-hvaibhav@ti.com>
 <20100821140541.GA31697@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044F1252C6@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36548 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0HWGai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 02:30:38 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044F1252C6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "byron.bbradley@gmail.com" <byron.bbradley@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

please break your lines at 80-characters. Also the [Hiremath, Vaibhav] 
is unnecessary.

On Mon, Aug 23, 2010 at 06:58:42AM +0200, ext Hiremath, Vaibhav wrote:
>> don't you need some locking on the irq handler ? a mutex maybe ? Just
>> wondering...
>>
>[Hiremath, Vaibhav] Yes definitely we do need locking here, I thought 
>of adding locking mechanism in subsequent patch, does it makes sense?

so you add a buggy patch and fix it later ? If you already know it's 
buggy, why not changing the patch that adds the bug ?

-- 
balbi

DefectiveByDesign.org
