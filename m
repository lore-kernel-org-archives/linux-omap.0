From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and
 restore
Date: Fri, 23 Jan 2009 08:52:42 +0100
Message-ID: <20090123085242.340b9e18@hyperion.delvare>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:9781 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbZAWHwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 02:52:53 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>

Hi Jagadeesh,

On Fri, 23 Jan 2009 12:51:23 +0530, Pakaravoor, Jagadeesh wrote:
> Sorry. I forgot to mention that this patch does not apply on
> mainline. It is meant for Linux Omap tree only.
> 
> Please review/ACK the patch, if you have time.

You should Cc Ben Dooks rather than me on i2c-omap patches, I do not
deal with embedded platforms.

-- 
Jean Delvare
