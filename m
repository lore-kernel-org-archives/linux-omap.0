From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: dts: OMAP3: Add GPMC controller and NAND memory
 to Overo
Date: Mon, 04 Feb 2013 09:58:33 +0100
Message-ID: <510F7839.9040603@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch> <20130201221618.GB22517@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:58491 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753961Ab3BDI6i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 03:58:38 -0500
In-Reply-To: <20130201221618.GB22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

>>
>> So how should we handle such case? Having several dtsi depending
>> on the Overo's revision would be a mess to my sense, considering
>> the non-conditional include inside the expansion boards' dts.
>> Or would it make sense to extend the DT binding for partitions?
>
> Yes makes sense to extend the binding to use the full flash memory
> if the size can be probed.
>

Ok, I will see for a patch soon (i.e. in the coming weeks).

Regards,

Florian
