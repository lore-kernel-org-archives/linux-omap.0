From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC] Common mechanism to identify Si revision
Date: Mon, 7 Sep 2009 09:09:21 -0500
Message-ID: <7D70B015-2775-446C-A286-062C955F7C5D@lixom.net>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com> <20090906124639.GA22239@lixom.net> <B85A65D85D7EB246BE421B3FB0FBB59301DD6C3EBD@dbde02.ent.ti.com> <20090907123404.GA26304@lixom.net> <B85A65D85D7EB246BE421B3FB0FBB59301DD6C436A@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpauth23.prod.mesa1.secureserver.net ([64.202.165.47]:54648
	"HELO smtpauth23.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753278AbZIGOQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 10:16:08 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C436A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sep 7, 2009, at 8:02 AM, Premi, Sanjeev wrote:


>>
>> I think it is a great step in the right direction. My only concern is
>> that the usage conventions are confusing:
>>
>> OMAP3_HAS_FEATURE(neon, NEON)
>
> [sp] This is only used to declare a function that would translate to:
>     unsigned int omap3_has_neon(void)
>     {
> 	     return (omap_features & OMAP_HAS_NEON);
>     }
>     EXPORT_SYMBOL(omap3_has_neon);
>
>     A user would always do something like:
>     if (omap_has_neon())
>         do_neon_specific_stuff();


Ok, all is well then. :)


-Olof
