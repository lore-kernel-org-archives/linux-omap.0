From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Board changes for gpio-keys
Date: Fri, 20 Aug 2010 14:30:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324305B73@dbde02.ent.ti.com>
References: <1282291963-1719-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57375 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0HTJAl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 05:00:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7K90c1L028956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 04:00:40 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7K90buj012198
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 14:30:37 +0530 (IST)
In-Reply-To: <1282291963-1719-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> +static int  omap_prox_activate(struct device *dev)

No tab needed before the function name - a space will do.
(at least for consistency with other functions in the file).

I don't know if this is serious enough to warrant a new revision,
but if you're reworking this patch for something else, please
fix this as well.

> +{
> +	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
> +	return 0;
> +}
> +


- Anand