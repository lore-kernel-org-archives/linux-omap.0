From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: fix initialize musb
Date: Fri, 10 Dec 2010 10:21:23 +0200
Message-ID: <20101210082123.GC2576@legolas.emea.dhcp.ti.com>
References: <1291914170-25415-1-git-send-email-tom.leiming@gmail.com>
 <4D011028.6020505@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52760 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752521Ab0LJIV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 03:21:28 -0500
Received: by ewy5 with SMTP id 5so2398056ewy.33
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 00:21:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D011028.6020505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tom.leiming@gmail.com, tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org

On Thu, Dec 09, 2010 at 11:21:44AM -0600, Nishanth Menon wrote:
>tom.leiming@gmail.com had written, on 12/09/2010 11:02 AM, the following:
>>From: Ming Lei <tom.leiming@gmail.com>
>>
>>Obviously we should only initialize musb once.
>>
>>Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>>---
>> arch/arm/mach-omap2/board-omap4panda.c |    3 ---
>> 1 files changed, 0 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
>>index 22599fc..85371be 100644
>>--- a/arch/arm/mach-omap2/board-omap4panda.c
>>+++ b/arch/arm/mach-omap2/board-omap4panda.c
>>@@ -393,9 +393,6 @@ static void __init omap4_panda_init(void)
>> 	usb_nop_xceiv_register();
>> 	omap4_ehci_init();
>> 	usb_musb_init(&musb_board_data);
>>-	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
>>-	if (!cpu_is_omap44xx())
>>-		usb_musb_init(&musb_board_data);
>> }
>> static void __init omap4_panda_map_io(void)
>Looks good to me. since this is for l-o master branch, I think this 
>should probably be squashed to:
>
>commit ec787afd05aad0cdb0b0d2948b356569805e5b30
>Author: Felipe Balbi <balbi@ti.com>
>Date:   Wed Dec 1 13:48:54 2010 +0200
>
>    arm: omap4: panda: initialize musb
>
>    initialize the musb port on pandaboard.
>
>    Signed-off-by: Felipe Balbi <balbi@ti.com>

that was probably a merge conflict auto-resolution mess:

Fixed now. Thanks. I added you SOB Ming.

-- 
balbi
