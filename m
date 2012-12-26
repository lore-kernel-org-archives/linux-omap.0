From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains
 functional states
Date: Wed, 26 Dec 2012 06:06:46 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6C83@DBDE01.ent.ti.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175253.6933.87846.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52757 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2LZGGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 01:06:53 -0500
In-Reply-To: <20121209175253.6933.87846.stgit@dusk.lan>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Pihet-XID, Jean" <j-pihet@ti.com>

Hi Paul,

A minor comment below.

On Sun, Dec 09, 2012 at 23:23:01, Paul Walmsley wrote:
[...]
> +
> +	pr_debug("powerdomain: convert pwrst (%0x,%0x) to fpwrst %0x\n",
> +		 pwrst, logic, *fpwrst);
> +

This function alone does not print the powerdomain name. Can you add that
in the final version?

Regards,
Vaibhav 

