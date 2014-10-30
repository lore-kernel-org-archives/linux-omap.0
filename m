From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Thu, 30 Oct 2014 07:02:11 +0100
Message-ID: <D7E4DB5C-45E3-44BE-AD26-41042FD0AAD6@gmail.com>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com> <1414420445-9020-1-git-send-email-frans.klaver@xsens.com> <544F6611.1000801@ti.com> <20141030014704.GE23619@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:52600 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaJ3GCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 02:02:20 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so261179wiv.2
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2014 23:02:19 -0700 (PDT)
In-Reply-To: <20141030014704.GE23619@ld-irv-0074>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

On 30 October 2014 02:47:04 CET, Brian Norris <computersforpeace@gmail.com> wrote:
>On Tue, Oct 28, 2014 at 11:46:57AM +0200, Roger Quadros wrote:
>> On 10/27/2014 04:34 PM, Frans Klaver wrote:
>> > Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename
>as
>> > omap_elm"), I don't have any mtd devices present on my am335x. This
>> > changes the link order of the omap_elm and omap2 objects, causing
>them
>> > to probe in the wrong order.
>> > 
>> > To fix this, make elm_config defer probing until the omap_elm
>driver is
>> > actually loaded.
>> > 
>> > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
>> 
>> Acked-by: Roger Quadros <rogerq@ti.com>
>
>Pushed to l2-mtd.git/for-3.18. Thanks!

Thanks 

>While this might be considered a link-order bug from long ago, it's not
>actually important until 3.18-rc1 where we changed the link order,
>right? So it doesn't need to go to -stable?

Correct. 

Thanks, 
Frans 


