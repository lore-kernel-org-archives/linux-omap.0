From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 12/13 v3] OMAP: GPIO: Implement GPIO as a platform device
Date: Mon, 21 Jun 2010 21:32:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5C92A5C@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
 <1276614348-5201-2-git-send-email-charu@ti.com>
 <1276614348-5201-3-git-send-email-charu@ti.com>
 <1276614348-5201-4-git-send-email-charu@ti.com>
 <1276614348-5201-5-git-send-email-charu@ti.com>
 <1276614348-5201-6-git-send-email-charu@ti.com>
 <1276614348-5201-7-git-send-email-charu@ti.com>
 <1276614348-5201-8-git-send-email-charu@ti.com>
 <1276614348-5201-9-git-send-email-charu@ti.com>
 <1276614348-5201-10-git-send-email-charu@ti.com>
 <1276614348-5201-11-git-send-email-charu@ti.com>
 <1276614348-5201-12-git-send-email-charu@ti.com>
 <1276614348-5201-13-git-send-email-charu@ti.com> <4C19353C.5020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab0FUQDZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 12:03:25 -0400
In-Reply-To: <4C19353C.5020302@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>


> [snip]
> 
> 
> > +static inline int init_gpio_info(struct platform_device *pdev)
> > +{
> > +       gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
> > +                               GFP_KERNEL);
> 
> This is the real issue with the gpio_bank_count.
> 
> You are creating a global driver information related to all instances of
> this device with a per device variable.
> You should store the registers per device, and that will remove the need
> for that global information.

Agreed. But "gpio_bank" can be removed only during cleanup, as this
information is spread around the whole driver and the current
gpio driver assumes it to be an array of all instances of the
device.

For now, would modify the code to get gpio_bank_count using
omap_hwmod_class() iteration count.

Until code cleanup is done, 'gpio_bank_count' would be given to driver
by means of a global variable/ a function pointer to omap_get_gpio_count().

> 
> Benoit
