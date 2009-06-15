From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] OMAP: McSPI: Fix RX DMA transfer path
Date: Mon, 15 Jun 2009 11:37:53 +0300
Message-ID: <4A360861.9040403@nokia.com>
References: <> <1244809910-4014-1-git-send-email-aaro.koskinen@nokia.com> <005a01c9ed7a$2a5227b0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18457 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZFOIiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 04:38:46 -0400
In-Reply-To: <005a01c9ed7a$2a5227b0$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hemanth V <hemanthv@ti.com>
Cc: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

Hello,

ext Hemanth V wrote:
> From: "Aaro Koskinen" <aaro.koskinen@nokia.com>
>> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>>
>> When data is read through DMA, the last element must be read separately
>> through the RX register. It cannot be transferred by the DMA. For further
>> details see e.g. OMAP3430 TRM.
> 
> Could you provide the section number and the version of TRM you are
> referring to.

Table 19-16 and section 19.6.2.5.1 in the public TRM.

>> Without the fix the driver causes extra clocks to be clocked to the
>> bus after DMA RX operations. This can cause interesting behaviour with
>> some devices.
> 
> Could you provide more details on the errors seen i.e is the transfer 
> aborted

There is an extra word, which a device can interpret as a command. Also 
if the word size != command size the device can hang. Unless the device 
hangs, you may not even notice anything.

A.
