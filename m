From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Wed, 27 Apr 2011 10:23:37 +0300
Message-ID: <4DB7C479.8030507@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il> <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il> <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:38318
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753386Ab1D0HQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 03:16:16 -0400
In-Reply-To: <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/27/11 07:23, Oleg Drokin wrote:
> Hello!
> 
> On Apr 24, 2011, at 6:09 PM, Mike Rapoport wrote:
>> -void __init usb_musb_init(struct omap_musb_board_data *board_data)
>> +static struct omap_musb_board_data musb_default_board_data = {
>> +	.interface_type		= MUSB_INTERFACE_ULPI,
>> +	.mode			= MUSB_OTG,
> 
> In fact can you make it more generic with ifdefs like this?
> (since there are tons of boards taht are client only or would like to be compiled in some other way):

I didn't want to change current functionality. The purpose of this patch is to
reduce amount of code shared among board files.
If certain board needs mode other than OTG it can still pass musb_board_data.

> +#ifdef CONFIG_USB_MUSB_OTG
> +       .mode                   = MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +       .mode                   = MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> +       .mode                   = MUSB_PERIPHERAL,
> +#endif
> 
>> +	.power			= 100,
>> +};
>> +
> 
> Thanks!
> 
> Bye,
>     Oleg
> 


-- 
Sincerely yours,
Mike.
