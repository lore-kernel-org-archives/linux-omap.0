From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Tue, 17 May 2011 16:16:18 +0300
Message-ID: <1305638178.1847.14.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>
	 <1305535980.2002.34.camel@deskari>  <4DD106BD.4070009@compulab.co.il>
	 <1305632940.1847.8.camel@deskari> <1305633414.1847.11.camel@deskari>
	 <4DD269DD.8020006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52002 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754640Ab1EQNQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 09:16:26 -0400
Received: by mail-ey0-f172.google.com with SMTP id 13so204104eye.17
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 06:16:23 -0700 (PDT)
In-Reply-To: <4DD269DD.8020006@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Tue, 2011-05-17 at 15:28 +0300, Igor Grinberg wrote:
> On 05/17/11 14:56, Tomi Valkeinen wrote:

> > We still don't know if it works or not =).
> 
> I thought Mayuresh checked this and confirmed, no?

No, as far as I understood he tried with the patch he attached, which
was something very different than this patch.

 Tomi


