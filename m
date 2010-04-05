From: Viral Mehta <Viral.Mehta@lntinfotech.com>
Subject: RE: USB on omap2430
Date: Mon, 5 Apr 2010 19:31:37 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343A35@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>,<20100329204159.GC31402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail142.messagelabs.com ([216.82.249.99]:16323 "EHLO
	mail142.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0DEOBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 10:01:53 -0400
In-Reply-To: <20100329204159.GC31402@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>On Fri, Mar 26, 2010 at 12:08:11PM +0100, ext Viral Mehta wrote:
>>I enabled "earlyprintk" and I have copy+pasted crashdump at the end of the email.
>>
>>It is not able to get "otg_get_transceiver()" since transceiver was never set.
>>OMAP2430 uses ISP1301 (grepped from SDP manual).
>>It is on I2C1 bus and address 0x2D if I read the manual correctly.

>isp1301 ?? there's a driver for that on drivers/usb/otg/isp1301_omap.c

Again I think I should be clear on that,
On OMAP2430, isp1301 transceiver is used for FS USB (or OHCI) only.
For HS USB (or musb) the transceiver used is Triton T2.

And currently I am debugging FS USB only. Sorry if earlier mail created confusion.
--
Viral

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
