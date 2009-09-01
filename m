From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: USB confusion
Date: Tue, 01 Sep 2009 06:20:13 -0600
Message-ID: <4A9D117D.2070105@mlbassoc.com>
References: <4A9D0898.4000400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:54059 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbZIAMUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 08:20:12 -0400
In-Reply-To: <4A9D0898.4000400@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 09/01/2009 05:42 AM, Gary Thomas wrote:
> What are the options to have USB Host support on the "normal"
> USB channels (i.e. not the OTG port)?
>
> This used to work on my platform but things stopped when I
> upgraded to the latest kernel :-(
>
> n.b. OTG host and gadget still work fine.
>
> Thanks
>

Following up on this, I made sure that CONFIG_USB_EHCI_HCD was defined.

Now I see these messages:
   ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
   Clock usbhost_48m_fck didn't enable in 100000 tries
   ehci-omap: probe of ehci-omap.0 failed with error -22

Any ideas what else I might be missing?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
