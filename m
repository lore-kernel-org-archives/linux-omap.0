From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
 MDK (Re: LDP support)
Date: Tue, 19 May 2009 15:54:15 -0500
Message-ID: <4A131C77.1050001@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com> <4A03F8DD.4070307@windriver.com> <87hbzv8rua.fsf@litku.valot.fi> <20090516081904.GB15328@n2100.arm.linux.org.uk> <87ljoube3z.fsf@litku.valot.fi> <20090518160957.GD7042@n2100.arm.linux.org.uk> <87zlda72r0.fsf@deeprootsystems.com> <20090518185934.GL7042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063AbZESUzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 16:55:05 -0400
In-Reply-To: <20090518185934.GL7042@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Sam Ravnborg <sam@ravnborg.org>, Kalle Valo <kalle.valo@iki.fi>, "stanley.miao" <stanley.miao@windriver.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>


Russell King - ARM Linux wrote:
> Moreover, I don't think forcing frame pointers to be enabled even with
> unwinding support is the right solution - if we have frame pointers
> there's no need for unwind support (so maybe the right answer is to
> force unwind support off for the time being?)

Ok, so I have tested this and if we add the following to the omap 
defconfigs then this will enable frame pointers and disable unwinding 
support. Hence, this should avoid the problems seen with the 2007q3 code 
sourcery compiler.

# CONFIG_ARM_UNWIND is not set

Tony, would this be ok with you?

Russell, sorry I did not see this thread earlier.

Jon

