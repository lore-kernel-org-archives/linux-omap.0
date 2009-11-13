From: =?ISO-8859-1?Q?Fr=E9d=E9ric_BEGOU?= <fbegou@sios.fr>
Subject: Re: [PATCH 1/2 (for-next)] ARM: OMAP3: Add support for the IGEP v2
 board (rev B)
Date: Fri, 13 Nov 2009 17:47:54 +0100
Message-ID: <4AFD8DBA.6040906@sios.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2e.orange.fr ([80.12.242.112]:32228 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbZKNP6O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Nov 2009 10:58:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id 856308000045
	for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 16:58:16 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id 249E28000BD2
	for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 16:58:16 +0100 (CET)
Received: from [192.168.48.102] (LPuteaux-151-43-16-109.w217-128.abo.wanadoo.fr [217.128.255.109])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id C619E8F264FB
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 17:47:54 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

For what I've seen on the Internet concerning your card, there is only 
one MMC card reader.
Besides, there is the following piece of code :

> +static struct twl4030_hsmmc_info mmc[] = {
> +       {
> +               .mmc            = 1,
> +               .wires          = 4,
> +               .gpio_cd        = -EINVAL,
> +               .gpio_wp        = -EINVAL,
> +       },
> +       {
> +               .mmc            = 2,
> +               .wires          = 4,
> +               .gpio_cd        = -EINVAL,
> +               .gpio_wp        = -EINVAL,
> +       },
> +       {}      /* Terminator */
> +};

Maybe I am mistaken, but doesn't that mean there are two MMC cards ?

I am interested in the subject, as I am trying to write my own board 
file for our custom, beagleboard-based card, with no success so far 
concerning the second MMC reader...

Best regards,

Fred


