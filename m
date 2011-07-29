From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Fri, 29 Jul 2011 18:07:17 -0500
Message-ID: <CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com> <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
 <20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com> <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
 <20110729134932.GA2258@foobar> <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:57693 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab1G2XHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 19:07:41 -0400
Received: by ewy3 with SMTP id 3so2949344ewy.36
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 16:07:37 -0700 (PDT)
In-Reply-To: <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 29, 2011 at 09:05, Felipe Balbi <balbi@ti.com> wrote:
>
>> +}
>> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);
>
> maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
> this ;-)

Sure.. but is this the way we want to go? if yes, I can post the
series in a formal way to the list.

Regards,
Nishanth Menon
