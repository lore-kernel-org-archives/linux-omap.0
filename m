From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] usb: musb: conditionally save and restore the context
 on suspend
Date: Mon, 25 Nov 2013 21:08:51 +0100
Message-ID: <5293AE53.9080606@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-2-git-send-email-zonque@gmail.com> <20131125194427.GZ18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:61260 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3KYUI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 15:08:57 -0500
In-Reply-To: <20131125194427.GZ18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/25/2013 08:44 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 25, 2013 at 08:39:49PM +0100, Daniel Mack wrote:
>> It appears not all platforms featuring a musb core need to save the musb
>> core registers at suspend time and restore them on resume.
>>
>> The dsps platform does, however. So add a bit in struct
>> musb_hdrc_platform_data to let platforms specify their need of such
>> action being taken.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
>>  include/linux/usb/musb.h     |  3 +++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 0a43329..a8ded57 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -2202,6 +2202,7 @@ static int musb_suspend(struct device *dev)
>>  {
>>  	struct musb	*musb = dev_to_musb(dev);
>>  	unsigned long	flags;
>> +	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
> 
> we don't want to have platform_data on DT-based boot. It's best to just
> save those registers unconditionally as it doesn't hurt.
> 

My concern about doing it unconditionally from the core is simply that I
fear regressions for other platforms. I can of course drop it if you're
certain that that's correct.

I can only test this on a dsps glue layer, and I have no documentation
for the musb core. All I'm left with here is fishing in muddy waters :/


Daniel

