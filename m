From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to retention
Date: Mon, 6 Aug 2012 15:29:38 +0200
Message-ID: <CAORVsuWvWDcK5fxGmXmbaHZQ48utRv6FoS2cOrYcP_8eFOLiBw@mail.gmail.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
	<1342704392-23657-7-git-send-email-t-kristo@ti.com>
	<500816BB.3090809@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55488 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab2HFN3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 09:29:40 -0400
Received: by lbbgm6 with SMTP id gm6so2807561lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 06:29:39 -0700 (PDT)
In-Reply-To: <500816BB.3090809@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi!

On Thu, Jul 19, 2012 at 4:16 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 07/19/2012 05:26 PM, Tero Kristo wrote:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>
>> Remove the FIXME's in the suspend sequence since
>> we now intend to support system level RET support.
>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> [Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
>> states]
>
>   Shouldn't Jean also have signed off?
Sure! I am OK with this change, feel free to add:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
