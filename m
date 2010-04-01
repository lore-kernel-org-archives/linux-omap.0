From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
Date: Thu, 01 Apr 2010 14:54:46 +0300
Message-ID: <1270122886.2704.100.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44990 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab0DALzA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 07:55:00 -0400
In-Reply-To: <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Mon, 2010-03-22 at 14:11 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> If you choose default output to DVI, the LCD backlight still
> gets powered, since panel->disable function never gets called for LCD.
> 
> So, during init put backlight GPIO to off state and the driverr
> code will decide which output to enable explicitly.

I'm not sure I understand this patch. You talk about choosing default
output (via kernel boot args, I presume), but the code checks for EVM
revision. What is the connection between EVM revision and selecting
display output?

 Tomi


