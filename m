From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] power_supply: add isp1704 charger detection driver
Date: Thu, 19 Aug 2010 16:29:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032422290C@dbde02.ent.ti.com>
References: <1282136465-1748-1-git-send-email-ext-heikki.krogerus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab0HSLBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 07:01:51 -0400
In-Reply-To: <1282136465-1748-1-git-send-email-ext-heikki.krogerus@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krogerus Heikki (EXT-Teleca/Helsinki)" <ext-heikki.krogerus@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "cbou@mail.ru" <cbou@mail.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "markus.lehtonen@nokia.com" <markus.lehtonen@nokia.com>, "roger.quadros@nokia.com" <roger.quadros@nokia.com>

> +static void isp1704_charger_work(struct work_struct *data)
> +{
> +	struct isp1704_charger	*isp =
> +		container_of(data, struct isp1704_charger, work);
> +
> +	/* FIXME Only supporting dedicated chargers even though isp1704 can
> +	 * detect HUB and HOST chargers. If the device has already been
> +	 * enumerated, the detection will break the connection.
> +	 */

Minor CodingStyle comment (since you're reworking the patch anyway).

Preferred style for multi-line comments is:

/*
 * FIXME Only supporting ...
 * detect HUB ...
 * enumerated ...
 */

